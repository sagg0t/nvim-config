return {
    zig = {
        {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = "${workspaceFolder}/zig-out/bin/glm_zig",
            args = {},
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        },
    },

    odin = {
        {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = "${workspaceFolder}/build/debug",
            args = {},
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        },
    },

    go = {
        {
            type = "delve",
            name = "Debug Go",
            request = "launch",
            program = vim.fn.getcwd
        },
        {
            type = "delve",
            name = "Debug Go test",
            request = "launch",
            mode = "test",
            program = "${file}"
        },
        {
            type = "delve",
            name = "Attach Go",
            request = "attach",
            processId = function()
                return require("dap.utils").pick_process()
            end
        }
    },

    ruby = {
        {
            type = "ruby_rdbg",
            request = "launch",
            name = "Debug file",
            args = { "${file}" }
        },
        {
            type = "ruby_rdbg",
            request = "launch",
            name = "Start Rails",
            args = { "-c", "--", "bundle", "exec", "rails", "s" }
        },
        {
            type = "ruby_rdbg",
            request = "attach",
            name = "Attach",
            args = function()
                local port = vim.fn.input("Port: ")
                return { "--", port }
            end
        }
    }
}
