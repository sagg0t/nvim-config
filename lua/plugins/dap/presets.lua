return {
    go = {
        adapter = function(callback, client_config)
            vim.validate("dap host", client_config.host, "string", true)
            local host = client_config.host or "127.0.0.1"

            vim.validate("dap port", client_config.port, "number", true)
            local port = client_config.port or "${port}"

            local delve_config = {
                type = "server",
                host = host,
                port = port,
                executable = {
                    command = "dlv",
                    args = { "dap", "-l", host .. ":" .. port, "--log", },
                    detached = vim.fn.has("win32") == 0,
                },
            }

            callback(delve_config)
        end,
        default_configurations = {
            {
                type = "go",
                name = "Debug Go",
                request = "launch",
                program = vim.fn.getcwd
            },
            {
                type = "go",
                name = "Debug Go test",
                request = "launch",
                mode = "test",
                program = "${file}"
            },
            {
                type = "go",
                name = "Attach Go",
                request = "attach",
                processId = function()
                    return require("dap.utils").pick_process()
                end
            }
        }
    },

    ruby = {
        adapter = function(callback, client_config)
            vim.validate("dap host", client_config.host, "string", true)
            local host = client_config.host or vim.env.RUBY_DEBUG_HOST or "127.0.0.1"

            vim.validate("dap port", client_config.port, "number", true)
            local port = client_config.port or "${port}"

            vim.validate("dap waiting", client_config.waiting, "number", true)
            local waiting = client_config.waiting or 500

            local config = {
                type = "server",
                host = host,
                port = port,
                executable = {
                    command = "rdbg",
                    args = {
                        "-O",
                        "--host",
                        host,
                        "--port",
                        port,
                    }
                },
                options = {
                    env = {
                        RUBY_DEBUG_OPEN = true
                    }
                }
            }

            if client_config.args then
                for _, arg in ipairs(client_config.args) do
                    table.insert(config.executable.args, arg)
                end
            end

            -- if client_config.command then
            --     vim.env.RUBY_DEBUG_OPEN = true
            --     vim.env.RUBY_DEBUG_HOST = host
            --     vim.env.RUBY_DEBUG_PORT = port
            --     run_cmd(
            --         client_config.command, client_config.args,
            --         client_config.current_line, client_config.current_file,
            --         client_config.error_on_failure
            --     )
            -- end

            -- Wait for rdbg to start
            vim.defer_fn(function() callback(config) end, waiting)
        end,
        default_configurations = {
            {
                type = "ruby",
                request = "launch",
                name = "Debug file",
                args = { "${file}" }
            },
            {
                type = "ruby",
                request = "launch",
                name = "Start Rails",
                args = { "-c", "--", "bundle", "exec", "rails", "s" }
            },
            {
                type = "ruby",
                request = "attach",
                name = "Attach",
                args = function()
                    local port = vim.fn.input("Port: ")
                    return { "--", port }
                end
            }
        }
    },

    zig = {
        adapter = {
            type = "server",
            port = "${port}",
            executable = {
                command = "lldb",
                -- args = { "--port", "${port}" }
            }
        },
        default_configurations = {
            {
                type = "zig",
                request = "launch",
                name = "Debug Zig",
                program = "${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}",
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
            }
        }
    }
}
