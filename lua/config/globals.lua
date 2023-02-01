local ok, plenary_reload = pcall(require, "plenary.reload")
if not ok then
  reloader = require
else
  reloader = plenary_reload.reload_module
end

P = function(v)
    print(vim.inspect(v))
    return v
end

RELOAD = function(...)
  return reloader(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

--=========================================
local uv = vim.loop

rdbg_config = {
    type = 'ruby';
    name = 'run current spec file';
    request = 'launch';
    command = "bundle exec rspec ";
    script = "/Users/Oleh_Volynets/dev/cerner/fhir_bulk_data_engine-r4/spec/fhir_bulk_data_engine/r4/utils/requested_resources_spec.rb";
    port = 38698;
    server = '127.0.0.1';
    waiting = 1000;
}

function launch_rdbg()
    local cmd = "rdbg"
    local stdin = uv.new_pipe(false)
    local stdout = uv.new_pipe(false)
    local stderr = uv.new_pipe(false)
    local port = math.random(10000, 20000)
    local spawn_opts = {
        stdio = { stdin, stdout, stderr },
        args = {
            "-n",
            "-O",
            "--port", port,
            "-c", "--",
            rdbg_config.command,
            rdbg_config.script
        },
        cwd = vim.fn.getcwd(),
        detached = false
    }

    local handle, pid_or_err
    do
        local function onexit(code, signal)
            stdin:close()
            stdout:close()
            stderr:close()
            handle:close()

            if signal == nil then
                print("No signal received")
            end

            if code ~= 0 then
                print('rdbg exited with code', code, 'and signal', signal)
            end
        end

        handle, pid_or_err = uv.spawn(cmd, spawn_opts, onexit)
        assert(handle, 'Error running rgdb: ' .. tostring(pid_or_err))

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


        uv.read_start(stdout, function(err, chunk)
            assert(not err, err)
            if chunk then
                vim.schedule(function()
                    require('dap.repl').append(chunk)
                end)
            end
        end)
    end

    -- local waiting = config.waiting or 500
    -- -- Wait for rdbg to start
    -- vim.defer_fn(
    --     function()
    --         callback({ type = "server", host = config.server, port = port })
    --     end,
    --     waiting)
end

return {}
