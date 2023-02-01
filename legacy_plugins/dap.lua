local dap = require('dap')
local uv = vim.loop
dap.set_log_level('trace')
require('dap-ruby').setup()

vim.keymap.set('n', '<Leader>db', require('dap').toggle_breakpoint)
vim.keymap.set('n', '<Leader>dc', require('dap').continue)
vim.keymap.set('n', '<Leader>dr', require('dap').repl.open)


dap.configurations.lua = {
    {
        type = 'nlua';
        request = 'attach';
        name = "Attach to running Neovim instance";
        host = function()
            local value = vim.fn.input('Host [127.0.0.1]: ')
            if value ~= "" then
                return value
            end
            return '127.0.0.1'
        end;
        port = function()
            local val = tonumber(vim.fn.input('Port: '))
            assert(val, "Please provide a port number")
            return val
        end;
    }
}

dap.adapters.nlua = function(callback, config)
    callback({ type = 'server', host = config.host, port = config.port })
end

dap.adapters.ruby = {
    type = "executable";
    command = "rdbg";
    args = { "-n", "-O", "--port", "38968", "-c", "--", "bundle", "exec", "rspec"};
    options = {
        cwd = vim.fn.getcwd();
    };
}

--[[ dap.adapters.ruby = function(callback, config)
    local cmd = "rdbg"
    local stdin = uv.new_pipe(false)
    local stdout = uv.new_pipe(false)
    local stderr = uv.new_pipe(false)
    local port = math.random(10000, 20000)
    local spawn_opts = {
        stdio = { stdin, stdout, stderr },
        args = {
            -- "-n",
            "-O",
            "--port", port,
            "-c", "--",
            config.command,
            config.script
        },
        cwd = vim.fn.getcwd(),
        detached = false
    }

    OPTS = spawn_opts

    local handle, pid_or_err
    local function onexit(code, signal)
        stdin:close()
        stdout:close()
        stderr:close()
        handle:close()

        if code ~= 0 then
            print('rdbg exited with code', code)
        end
    end

    handle, pid_or_err = uv.spawn(cmd, spawn_opts, onexit)

    if handle == nil then
        local msg = string.format('Spawning DAP server with cmd: `%s` failed', cmd)
        if string.match(pid_or_err, 'ENOENT') then
            msg = msg .. '. The DAP server is either not installed, missing from PATH, or not executable.'
        else
            msg = msg .. string.format(' with error message: %s', pid_or_err)
        end
        vim.notify(msg, vim.log.levels.WARN)
        return
    end
    assert(handle, 'Error running rgdb: ' .. tostring(pid_or_err))


    uv.read_start(stdout, function(err, chunk)
        assert(not err, err)
        if chunk then
            vim.schedule(function()
                require('dap.repl').append(chunk)
            end)
        end
    end)

    local waiting = config.waiting or 500
    -- Wait for rdbg to start
    vim.defer_fn(
        function()
            callback({ type = "server", host = config.server, port = 13656 })
        end,
        waiting)
end ]]

dap.configurations.ruby = {
    {
        type = 'ruby';
        name = 'run current spec file';
        request = 'launch';
        command = "bundle exec rspec ${file}";
        port = 38698;
    },
    --     {
    --         type = 'ruby';
    --         name = 'run rspec';
    --         request = 'attach';
    --         command = "bundle exec rspec";
    --         script = "";
    --         port = 38698;
    --         server = '127.0.0.1';
    --         waiting = 1000;
    --     }
}
