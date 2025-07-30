local api = vim.api
local ns = api.nvim_create_namespace("saggot.task-runner.history-preview")

--- @param entries HistoryEntry[]
--- @return string[]
local function format_entries(entries)
    local max_exit_code_len = 0
    local max_ID_len = 0
    for _, entry in ipairs(entries) do
        if entry.code then
            max_exit_code_len = math.max(max_exit_code_len, #tostring(entry.code))
        end
        max_ID_len = math.max(max_ID_len, #tostring(entry.ID))
    end

    local ID_format = "%" .. tostring(max_ID_len) .. "d"
    local exit_code_format = "(%" .. tostring(max_exit_code_len) .. "d)"

    local finished_task_format = ID_format .. " " .. exit_code_format .. " %s"
    local running_task_format = ID_format .. " (" .. string.rep("?", max_exit_code_len) .. ") %s"

    return vim.tbl_map(function(entry)
        if entry.code then
            return string.format(finished_task_format, entry.ID, entry.code, entry.cmd)
        else
            return string.format(running_task_format, entry.ID, entry.cmd)
        end
    end, entries)
end

--- @class HistoryPreview
---
--- @field output_buf number?
--- @field output_win_id number?
--- @field output_aucmd_id number?
---
--- @field index_buf number?
--- @field index_win_id number?
local HistoryPreview = {}
HistoryPreview.__index = HistoryPreview

--- @return HistoryPreview
function HistoryPreview.new()
    local self = setmetatable({}, HistoryPreview)

    return self
end

--- @param history History
function HistoryPreview:toggle(history)
    if self.index_win_id then
        self:close()
    else
        self:update_index(history)
        self:open(history)
    end
end

--- @param history History
function HistoryPreview:open(history)
    if not self.index_win_id then
        vim.cmd("topleft vsplit")
        self.index_win_id = api.nvim_get_current_win()
        api.nvim_win_set_buf(self.index_win_id, self.index_buf)

        api.nvim_create_autocmd("WinClosed", {
            buffer = self.index_buf,
            once = true,
            desc = "Cleanup task runner history preview state",
            callback = function()
                self.index_win_id = nil
                self.output_win_id = nil
            end
        })
    end

    self:attach_history_nav_cb(function()
        if #history.entries == 0 then return end

        local row, _ = unpack(api.nvim_win_get_cursor(self.index_win_id))
        local desired_buf = history.entries[row].buf

        if (not self.output_win_id) or self.output_buf == desired_buf then return end

        self.output_buf = desired_buf
        api.nvim_win_set_buf(self.output_win_id, self.output_buf)
    end)

    if #history.entries > 0 then
        self.output_buf = history.entries[1].buf

        if not self.output_win_id then
            self.output_win_id = api.nvim_open_win(self.output_buf, false, {
                split = "above",
                height = vim.o.lines - history.capacity - 3, -- statusline, cmdline, win separator
                win = self.index_win_id,
            })

            if self.output_aucmd_id then
                api.nvim_del_autocmd(self.output_aucmd_id)
            end

            self:reattach_output_pane_close_cb()
        else
            api.nvim_win_set_buf(self.output_win_id, self.output_buf)
        end
    end
end

function HistoryPreview:close()
    local index_win_id = self.index_win_id
    local output_win_id = self.output_win_id

    if index_win_id then
        api.nvim_win_close(index_win_id, true)
        self.index_win_id = nil
    end

    if output_win_id then
        api.nvim_win_close(output_win_id, true)
        self.output_win_id = nil
    end
end

--- @param history History
function HistoryPreview:update_index(history)
    if not self.index_buf then
        self.index_buf = api.nvim_create_buf(true, true)
        api.nvim_buf_set_name(self.index_buf, "Task history")
    end

    local marks = api.nvim_buf_get_extmarks(self.index_buf, ns, 0, -1, {})
    for _, m in ipairs(marks) do
        api.nvim_buf_del_extmark(self.index_buf, ns, m[1])
    end

    if #history.entries == 0 then
        self:index_buf_atomic_write({"Nothing has been run so far"})
        api.nvim_buf_set_extmark(self.index_buf, ns, 0, 0, {line_hl_group = "DiagnosticVirtualTextWarn"})
        return
    end

    local lines = format_entries(history.entries)
    self:index_buf_atomic_write(lines)

    for ln, _ in ipairs(lines) do
        local hl_group = "DiagnosticVirtualTextError"
        local exit_code = history.entries[ln].code

        if exit_code == nil then
            hl_group = "DiagnosticVirtualTextInfo"
        elseif exit_code == 0 then
            hl_group = "DiagnosticVirtualTextOk"
        end

        api.nvim_buf_set_extmark(self.index_buf, ns, ln - 1, 0, {line_hl_group = hl_group})
    end

    self:reattach_output_pane_close_cb()
end

function HistoryPreview:index_buf_atomic_write(lines)
    api.nvim_set_option_value("modifiable", true, {buf = self.index_buf})
    api.nvim_buf_set_lines(self.index_buf, 0, -1, false, lines)
    api.nvim_set_option_value("modifiable", false, {buf = self.index_buf})
end

function HistoryPreview:attach_history_nav_cb(cb)
    api.nvim_create_autocmd("CursorMoved", {
        buffer = self.index_buf,
        desc = "Update preview buffer when selecting different history entry",
        callback = cb
    })
    -- api.nvim_create_autocmd("CursorHold", {
    --     buffer = self.index_buf,
    --     callback = function()
    --         vim.print("Cursor hold")
    --     end
    -- })
end

function HistoryPreview:reattach_output_pane_close_cb()
    if self.output_aucmd_id then
        api.nvim_del_autocmd(self.output_aucmd_id)
    end

    api.nvim_create_autocmd("WinClosed", {
        buffer = self.output_buf,
        once = true,
        callback = function(evt)
            local win_id = tonumber(evt.match)

            if win_id == self.output_win_id then
                self:close()
            end
        end
    })
end

--- @return boolean
function HistoryPreview:is_open()
    return not (self.index_win_id == nil)
end

return HistoryPreview
