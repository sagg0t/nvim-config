local api = vim.api

--- @type History
local History = require("task_runner.history")
--- @type HistoryPreview
local HistoryPreview = require("task_runner.history.preview")


--- @class Task
--- @field cmd string[]
--- @field key string


--- @param code number
--- @return string
local function format_exit_code(code)
    if code == 0 then
        return string.format("\x1b[32m%d\x1b[0m", code) -- green
    else
        return string.format("\x1b[31m%d\x1b[0m", code) -- red
    end
end


--- @class Output
--- @field win_id number?
--- @field close_cb number?



--- @class TaskRunner
--- @field _run_couner number
--- @field tasks Task[]
--- @field history History
---
--- @field output Output
--- @field history_preview HistoryPreview
local TaskRunner = {}
TaskRunner.__index = TaskRunner

--- @return TaskRunner
function TaskRunner.new()
    local self = setmetatable({}, TaskRunner)

    self.tasks = {}
    self._run_couner = 0
    self.history = History.new(20)
    self.output = {
        win_id = nil,
        close_cb = nil
    }
    self.history_preview = HistoryPreview.new()

    return self
end

--- @param cmd string[]
function TaskRunner:run(cmd)
    local buf = api.nvim_create_buf(false, true)
    if buf == 0 then
        vim.notify("[task runner] failed to create buf", vim.log.levels.ERROR)
        return
    end

    local run_idx = self:_run_index()
    api.nvim_buf_set_name(buf, "Task output " .. tostring(run_idx))

    local cmd_formatted = table.concat(cmd, " ")

    self.history:push({ID = run_idx, cmd = cmd_formatted, buf = buf})
    self:update_history_preview()

    local greeting = {
        string.format("[%d] %s", run_idx, cmd_formatted),
        "",
    }

    local lc = 0 -- line count
    api.nvim_buf_set_lines(buf, lc, -1, false, greeting)
    lc = lc + #greeting

    if not self.output.win_id then
        local origin_win = api.nvim_get_current_win()
        vim.cmd("botright vsplit")
        self.output.win_id = api.nvim_get_current_win()
        api.nvim_set_current_win(origin_win)
    else
        -- output.win_id & output.close_cb are set/cleared together
        api.nvim_del_autocmd(self.output.close_cb)
    end

    api.nvim_win_set_buf(self.output.win_id, buf)
    self:attach_win_close_cb(buf)

    local push_out = function(err, data)
        if err then
            vim.notify("[task runner] output error: " .. err, vim.log.levels.ERROR)
            return
        end

        if data then
            local lines = vim.split(data, "\n", {trimempty=true})

            api.nvim_buf_set_lines(buf, lc, -1, false, lines)
            lc = lc + #lines

            if not vim.endswith(data, "\n") then
                lc = lc - 1
            end
        end
    end

    local on_exit = vim.schedule_wrap(function(res)
        api.nvim_buf_set_lines(buf, lc, -1, false, {"", string.format("Exit %s", format_exit_code(res.code))})
        lc = lc + 1

        self.history:update_entry_code(run_idx, res.code)
        self:update_history_preview()
        local chan_id = api.nvim_open_term(buf, {})
        if chan_id == 0 then
            vim.notify("[task runner] failed to create term", vim.log.levels.ERROR)
            return
        end
    end)

    vim.system(cmd, {
        text = false,
        stdout = vim.schedule_wrap(push_out),
        stderr = vim.schedule_wrap(push_out),
    }, on_exit)
end

function TaskRunner:attach_win_close_cb(buf)
    self.output.close_cb = api.nvim_create_autocmd("WinClosed", {
        buffer = buf,
        desc = "Cleanup after task runner output window is closed",
        callback = function(evt)
            local closed_win_id = tonumber(evt.match)
            if self.output.win_id == closed_win_id then
                self.output.win_id = nil
                api.nvim_del_autocmd(self.output.close_cb)
                self.output.close_cb = nil
            end
        end,
    })
end

function TaskRunner:toggle_output()
    if self.output.win_id then
        api.nvim_win_close(self.output.win_id, true)
        self.output.win_id = nil
    else
        if #self.history.entries > 0 then
            self:create_output_win()
            api.nvim_win_set_buf(self.output.win_id, self.history.entries[1].buf)
        else
            vim.notify("[task runner] no output")
        end
    end
end

function TaskRunner:create_output_win()
    local origin_win = api.nvim_get_current_win()
    vim.cmd("botright vsplit")
    self.output.win_id = api.nvim_get_current_win()
    api.nvim_set_current_win(origin_win)
end

function TaskRunner:toggle_history()
    self.history_preview:toggle(self.history)
end

--- @param task Task
function TaskRunner:add(task)
    vim.validate("cmd", task.cmd, "table")
    vim.validate("key", task.key, "string")

    self.tasks[#self.tasks + 1] = task

    vim.keymap.set("n", task.key, function()
        self:run(task.cmd)
    end)
end

function TaskRunner:update_history_preview()
    if not self.history_preview:is_open() then return end

    self.history_preview:open(self.history)
    vim.schedule(function()
        self.history_preview:update_index(self.history)
    end)
end

--- @return number
function TaskRunner:_run_index()
    local n = self._run_couner
    self._run_couner = self._run_couner + 1

    return n
end

function TaskRunner:inspect()
    vim.print(self)
end

return TaskRunner
