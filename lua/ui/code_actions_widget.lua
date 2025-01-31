local ms = vim.lsp.protocol.Methods


local function get_action_index()
    local cur_text = vim.api.nvim_get_current_line()
    local num = cur_text:match('%[(%d+)%]%s+%S')
    if num then
        num = tonumber(num)
    end
    -- if not num or not actions[num] then
    --     return
    -- end

    return num
end

--- @class CodeActionsWidget
--- @field win number
--- @field bufnr number
--- @field choices table[]
--- @field opts table
local CodeActionsWidget = {}
CodeActionsWidget.__index = CodeActionsWidget

--- @return CodeActionsWidget
function CodeActionsWidget.new(results, opts)
    local self = setmetatable({}, CodeActionsWidget)

    self.choices = {}
    self.opts = opts or {}

    for _, result in pairs(results) do
        for _, action in pairs(result.result or {}) do
            if self:action_filter(action) then
                table.insert(self.choices, { action = action, ctx = result.ctx })
            end
        end
    end

    return self
end

function CodeActionsWidget:run()
    if #self.choices == 0 then
        vim.notify('No code actions available', vim.log.levels.INFO)
        return
    end

    if self.opts.apply and #self.choices == 1 then
        self:on_user_choice(self.choices[1])
        return
    end

    self:create_buf()
    self:create_win()
end

function CodeActionsWidget:create_buf()
    local lines = {}
    self.max_len = 0
    for idx, item in ipairs(self.choices) do
        local title = "[" .. idx .. "] "
            .. item.action.title:gsub('\r\n', '\\r\\n'):gsub('\n', '\\n')
            .. " (" .. vim.lsp.get_client_by_id(item.ctx.client_id).name .. ")"

        lines[idx] = title
        if self.max_len < #title then
            self.max_len = #title
        end
    end

    self.bufnr = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_lines(self.bufnr, 0, 30, false, lines)

    vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = self.bufnr,
        callback = function()
            self:handle_cursor_move()
        end
    })

    vim.keymap.set("n", "q", function() self:close_win() end, { buffer = self.bufnr })
    vim.keymap.set("n", "<Esc>", function() self:close_win() end, { buffer = self.bufnr })
    vim.keymap.set("n", "<Enter>", function() self:handle_choice_confirm() end, { buffer = self.bufnr })

    for idx, choice in ipairs(self.choices) do
        vim.keymap.set("n", tostring(idx), function()
            self:on_user_choice(choice)
        end, { buffer = self.bufnr })
    end
end

function CodeActionsWidget:create_win()
    self.win = vim.api.nvim_open_win(0, true, {
        relative = "cursor",
        row = 1,
        col = 0,
        title = "Code Actions",
        width = self.max_len,
        height = #self.choices,
        border = "rounded",
        style = "minimal"
    })

    if self.win == 0 then
        vim.notify("failed to create a window", vim.log.levels.ERROR)
        return
    end

    vim.api.nvim_win_set_buf(self.win, self.bufnr)
    vim.api.nvim_win_set_cursor(self.win, { 1, 1 })
end

function CodeActionsWidget:close_win()
    vim.api.nvim_win_close(self.win, true)
    vim.api.nvim_buf_delete(self.bufnr, { force = true })
end

function CodeActionsWidget:handle_cursor_move()
    local current_line = vim.api.nvim_win_get_cursor(self.win)[1]

    vim.api.nvim_win_set_cursor(self.win, { current_line, 1 })

    local choice_idx = get_action_index()
    local choice = self.choices[choice_idx]
    -- preview.action_preview(win, buf, tuple)
end

function CodeActionsWidget:handle_choice_confirm()
    local choice_idx = get_action_index()
    local choice = self.choices[choice_idx]
    self:on_user_choice(choice)
end

function CodeActionsWidget:apply_action(action, client, ctx)
    if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
    end
    local a_cmd = action.command
    if a_cmd then
        local command = type(a_cmd) == 'table' and a_cmd or action
        client:exec_cmd(command, ctx)
    end
end

function CodeActionsWidget:on_user_choice(choice)
    self:close_win()

    if not choice then
        return
    end

    local client = assert(vim.lsp.get_client_by_id(choice.ctx.client_id))
    local action = choice.action
    local bufnr = assert(choice.ctx.bufnr, 'Must have buffer number')

    local reg = client.dynamic_capabilities:get(ms.textDocument_codeAction, { bufnr = self.bufnr })

    local supports_resolve = vim.tbl_get(reg or {}, 'registerOptions', 'resolveProvider')
        or client.supports_method(ms.codeAction_resolve)

    if not action.edit and client and supports_resolve then
        client.request(ms.codeAction_resolve, action, function(err, resolved_action)
            if err then
                if action.command then
                    self:apply_action(action, client, choice.ctx)
                else
                    vim.notify(err.code .. ': ' .. err.message, vim.log.levels.ERROR)
                end
            else
                self:apply_action(resolved_action, client, choice.ctx)
            end
        end, bufnr)
    else
        self:apply_action(action, client, choice.ctx)
    end
end

function CodeActionsWidget:action_filter(a)
    -- filter by specified action kind
    if self.opts and self.opts.context and self.opts.context.only then
        if not a.kind then
            return false
        end
        local found = false
        for _, o in ipairs(self.opts.context.only) do
            -- action kinds are hierarchical with . as a separator: when requesting only 'type-annotate'
            -- this filter allows both 'type-annotate' and 'type-annotate.foo', for example
            if a.kind == o or vim.startswith(a.kind, o .. '.') then
                found = true
                break
            end
        end
        if not found then
            return false
        end
    end
    -- filter by user function
    if self.opts and self.opts.filter and not self.opts.filter(a) then
        return false
    end
    -- no filter removed this action
    return true
end

return CodeActionsWidget
