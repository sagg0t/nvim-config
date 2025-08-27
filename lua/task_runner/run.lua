local color = require("util.color")

local api = vim.api

--- @type FnWrapper
local FnWrapper = require("task_runner.fn_wrapper")

--- @class Run
---
--- @field run_idx number
--- @field buf number
--- @field output_win number
--- @field chan_id number
--- @field task Task
--- @field callback function
local Run = {}
Run.__index = Run

--- @return Run
function Run.new(run_idx, chan_id, buf, output_win, task, callback)
    local self = setmetatable({}, Run)

    self.run_idx = run_idx
    self.buf = buf
    self.chan_id = chan_id
    self.task = task
    self.output_win = output_win
    self.callback = callback

    return self
end

--- @param cmd_idx number?
function Run:go(cmd_idx)
    cmd_idx = cmd_idx or 1
    if cmd_idx > #self.task.cmd then
        self.callback(0) -- successful completion of all commands
        return
    end

    local cmd = self.task.cmd[cmd_idx]

    if getmetatable(cmd) == FnWrapper then
        cmd()
        return self:go(cmd_idx + 1)
    end

    --- @cast cmd -FnWrapper

    local stdio = self:_get_stdio(cmd)

    local greeting = string.format("\x1b[0;1mSTART [%d] %s\x1b[0m\n", self.run_idx, cmd.title)
    self:_write(greeting)

    local start_time = vim.uv.hrtime()

    local function on_exit(res)
        local end_time = vim.uv.hrtime()

        self:_write(string.format(
            "\n\n\x1b[1;37mEND\x1b[0m [Process exited %s] - %f sec\n\n",
            res.code == 0 and color.green(res.code) or color.red(res.code),
            (end_time - start_time) / 1000000000
        ))

        if res.code ~= 0 then
            self.callback(res.code)
            return
        end

        return self:go(cmd_idx + 1)
    end

    vim.system(cmd, {
        stdin = stdio.stdin,
        stdout = vim.schedule_wrap(stdio.stdout),
        stderr = vim.schedule_wrap(stdio.stderr),
        cwd = self.task.cwd,
        env = self.task.env,
        timeout = self.task.timeout
    }, vim.schedule_wrap(on_exit))
end

function Run:_write(s)
    api.nvim_chan_send(self.chan_id, s)
end

--- @return boolean
function Run:_should_write_separator(cmd_idx)
    local cmd = self.task.cmd[cmd_idx]
    if cmd_idx == 1 or getmetatable(cmd) == FnWrapper then return false end

    for idx = 1, cmd_idx - 1 do
        if getmetatable(self.task.cmd[idx]) ~= FnWrapper then
            return true
        end
    end

    return false
end

--- @param cmd Command
--- @return {stdin: (string|string[]), stdout: function?, stderr: function?}
function Run:_get_stdio(cmd)
    local stdin = cmd.stdin
    if type(stdin) == "function" then
        stdin = stdin()
    elseif type(stdin) == "table" and stdin.file then
        local in_file = assert(io.open(stdin.file))
        stdin = in_file:read("*a")
        in_file:close()
    end

    local function push_to_buf(data)
        if not data then return end

        self:_write(data)
    end

    local function file_stream(out)
        assert(type(out) == "table")
        assert(out.file, "[task runner] file path must be provided")

        local out_file = assert(io.open(out.file, "w"))

        return function(data)
            if not data then
                self:_write("output closed")
                out_file:flush()
                out_file:close()
                return
            end

            out_file:write(data)
        end
    end

    local function out_handler(send, only_send)
        return function(err, data)
            assert(not err, "[task runner] output error: " .. (err or ""))

            if send then
                if not only_send then push_to_buf(data) end
                send(data)
            else
                push_to_buf(data)
            end
        end
    end

    local stdout_send = cmd.stdout and file_stream(cmd.stdout)
    local stdout = out_handler(stdout_send, cmd.stdout and cmd.stdout.only)

    local stderr_send = cmd.stderr and cmd.stderr ~= "stdout" and file_stream(cmd.stderr)
    local stderr = cmd.stderr == "stdout" and stdout or out_handler(stderr_send, cmd.stderr and cmd.stderr.only)

    return {
        stdin = stdin,
        stdout = stdout,
        stderr = stderr,
    }
end

return Run
