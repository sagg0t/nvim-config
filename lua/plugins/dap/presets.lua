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
    }
}
