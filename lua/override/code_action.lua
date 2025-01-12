-- vim.cmd("fclose")
-- vim.cmd("messages clear")

local ms = vim.lsp.protocol.Methods

local CodeAction = require("ui.code_actions_widget")

local function range_from_selection(bufnr, mode)
    -- TODO: Use `vim.fn.getregionpos()` instead.

    -- [bufnum, lnum, col, off]; both row and column 1-indexed
    local start = vim.fn.getpos('v')
    local end_ = vim.fn.getpos('.')
    local start_row = start[2]
    local start_col = start[3]
    local end_row = end_[2]
    local end_col = end_[3]

    -- A user can start visual selection at the end and move backwards
    -- Normalize the range to start < end
    if start_row == end_row and end_col < start_col then
        end_col, start_col = start_col, end_col
    elseif end_row < start_row then
        start_row, end_row = end_row, start_row
        start_col, end_col = end_col, start_col
    end
    if mode == 'V' then
        start_col = 1
        local lines = vim.api.nvim_buf_get_lines(bufnr, end_row - 1, end_row, true)
        end_col = #lines[1]
    end
    return {
        ['start'] = { start_row, start_col - 1 },
        ['end'] = { end_row, end_col - 1 },
    }
end

local function code_action(opts)
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
            params = vim.lsp.util.make_given_range_params(start, end_, bufnr, client.offset_encoding)
        elseif mode == 'v' or mode == 'V' then
            local range = range_from_selection(bufnr, mode)
            params = vim.lsp.util.make_given_range_params(
                range.start,
                range['end'],
                bufnr,
                client.offset_encoding
            )
        else
            params = vim.lsp.util.make_range_params(win)
        end
        params.context = context

        client.request(ms.textDocument_codeAction, params, on_result, bufnr)
    end
end

return code_action
