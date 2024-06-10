vim.cmd("fclose")
vim.cmd("messages clear")

local ms = vim.lsp.protocol.Methods

local CodeAction = require("ui.code_actions_widget")

function vim.lsp.buf.code_action(opts)
    vim.validate({ options = { opts, 't', true } })
    opts = opts or {}

    local bufnr = vim.api.nvim_get_current_buf()
    local context = opts.context or {}
    if not context.triggerKind then
        context.triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked
    end
    if not context.diagnostics then
        context.diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr)
    end

    local clients = vim.lsp.get_clients({ bufnr = bufnr, method = ms.textDocument_codeAction })
    local remaining = #clients
    if remaining == 0 then
        if next(vim.lsp.get_clients({ bufnr = bufnr })) then
            vim.notify(vim.lsp._unsupported_method(ms.textDocument_codeAction), vim.log.levels.WARN)
        end
        return
    end

    local results = {}
    local win = vim.api.nvim_get_current_win()
    local mode = vim.api.nvim_get_mode().mode

    local function on_result(err, result, ctx)
        results[ctx.client_id] = { error = err, result = result, ctx = ctx }
        remaining = remaining - 1
        if remaining == 0 then
            local widget = CodeAction.new(results, opts)
            widget:run()
        end
    end

    for _, client in ipairs(clients) do
        local params
        if opts.range then
            assert(type(opts.range) == 'table', 'code_action range must be a table')
            local start = assert(opts.range.start, 'range must have a `start` property')
            local end_ = assert(opts.range['end'], 'range must have a `end` property')
            params = vim.lsp.util.make_given_range_params(start, end_, bufnr)
        elseif mode == 'v' or mode == 'V' then
            local region = vim.region(bufnr, "'<", "'>", "b", true)
            local range_start = { region[1] + 1, region[1][1] }
            local range_end = { region[-1] + 1, region[-1][2] }

            params =
                vim.lsp.util.make_given_range_params(range_start, range_end, bufnr)
        else
            params = vim.lsp.util.make_range_params(win)
        end
        params.context = context

        client.request(ms.textDocument_codeAction, params, on_result, bufnr)
    end
end

vim.keymap.set({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action)
