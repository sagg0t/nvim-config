local api = vim.api

--- @type History
local History = require("task_runner.history")
--- @type HistoryPreview
local HistoryPreview = require("task_runner.history.preview")
--- @type FnWrapper
local FnWrapper = require("task_runner.fn_wrapper")
--- @type Run
local Run = require("task_runner.run")


--- @class Command: string[]
--- @field title string?
--- @field stdin (string|string[]|{file: string}|fun(): string)?
--- @field stdout OutStream?
--- @field stderr (OutStream|"stdout")?


--- @class Task
--- @field title string?
--- @field cmd (Command|FnWrapper)[]
--- @field key string
--- @field cwd string?
--- @field env table<string,string|number>?
--- @field timeout number?


--- @class Output
--- @field win_id number?
--- @field close_cb number?


--- @class Config
--- @field history_size number?
--- @field keymap table<string, string>?


--- @type Config
local default_config = {
    history_size = 20,
    keymap = {
        toggle_history = "<Leader>rh",
        toggle_output = "<Leader>ro",
    }
}


--- @class TaskRunner
---
--- @field config Config
---
--- @field tasks Task[]
--- @field _run_couner number
--- @field output Output
---
--- @field history History
--- @field history_preview HistoryPreview
local TaskRunner = {}
TaskRunner.__index = TaskRunner


--- @param config Config?
--- @return TaskRunner
function TaskRunner.new(config)
    local self = setmetatable({}, TaskRunner)

    config = config or {}
    self.config = vim.tbl_extend("force", {}, default_config, config)

    self.tasks = {}
    self._run_couner = 0
    self.output = {
        win_id = nil,
        close_cb = nil
    }

    self.history = History.new(self.config.history_size)
    self.history_preview = HistoryPreview.new()

    if self.config.keymap then
        if self.config.keymap.toggle_output then
            vim.keymap.set("n",
                self.config.keymap.toggle_output,
                function() self:toggle_output() end)
        end

        if self.config.keymap.toggle_history then
            vim.keymap.set("n",
                self.config.keymap.toggle_history,
                function() self:toggle_history() end)
        end
    end

    return self
end

--- @param task Task
function TaskRunner:run(task)
    local buf = api.nvim_create_buf(false, true)
    assert(buf ~= 0, "[task runner] failed to create buf")

    local chan_id = api.nvim_open_term(buf, {})
    assert(chan_id ~= 0, "[task runner] failed to create term")

    local run_idx = self:_run_index()
    api.nvim_buf_set_name(buf, "Task output " .. tostring(run_idx))

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

    local run = Run.new(run_idx, chan_id,
        buf, self.output.win_id, task,
        function(code)
            self.history:update_exit_code(run_idx, code)
            self:update_history_preview()
        end)

    self.history:push({ID = run_idx, cmd = task.title, buf = buf})
    self:update_history_preview()

    run:go()
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
        self:close_output()
    else
        self:open_output()
    end
end

function TaskRunner:close_output()
    api.nvim_win_close(self.output.win_id, true)
    self.output.win_id = nil
end

function TaskRunner:open_output()
    if #self.history.entries > 0 then
        self:create_output_win()
        api.nvim_win_set_buf(self.output.win_id, self.history.entries[1].buf)
    else
        vim.notify("[task runner] no output")
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

--- @class TaskRequest: Task
--- @field cmd (string|Command|FnWrapper|function)[]
---
--- @param task TaskRequest
function TaskRunner:add(task)
    vim.validate("cmd", task.cmd, "table")
    vim.validate("key", task.key, "string")

    if type(task.cmd[1]) == "string" then
        task.cmd = { task.cmd --[[@as Command]] } -- wrap single command tasks
    end

    for idx, cmd in ipairs(task.cmd) do
        if type(cmd) == "table" then
            cmd.title = cmd.title or table.concat(cmd, " "):gsub("\x1b%[[%d;]*m", "")
        elseif type(cmd) == "function" then
            task.cmd[idx] = FnWrapper.new(cmd)
        else
            error("[task runner] unsupported task type: " .. type(cmd) .. ". Only supports list of shell commands (string[]) or functions")
        end
    end

    if not task.title then
        local titles = vim.tbl_map(function(cmd)
            return cmd.title
        end, task.cmd)

        task.title = table.concat(titles, " && ")
    end

    table.insert(self.tasks, task)

    vim.keymap.set("n", task.key, function() self:run(task) end)
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

local runner = TaskRunner.new()

runner:add({
    cmd = {
        function() print("test") end,
        {"sleep", "2"},
        {
            "echo",
            "\x1b[31masldkfj\x1b[0m",
            stdout = {
                file = "test_out.txt"
            }
        },
        {"sleep", "1"},
        {"printf", "\x1b[31masldkfj\x1b[0m"},
        function() vim.notify("from task: askldjflaskdfj") end
    },
    key = "<Leader>r1",
})
vim.keymap.set("n", "<Leader>ri", function() runner:inspect() end)

return TaskRunner
