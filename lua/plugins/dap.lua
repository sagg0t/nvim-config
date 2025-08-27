-- vim.keymap.set({"n", "v"}, "<Leader>dh", function()
--   require("dap.ui.widgets").hover()
-- end)
-- vim.keymap.set({"n", "v"}, "<Leader>dp", function()
--   require("dap.ui.widgets").preview()
-- end)
-- vim.keymap.set("n", "<Leader>df", function()
--   local widgets = require("dap.ui.widgets")
--   widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set("n", "<Leader>ds", function()
--   local widgets = require("dap.ui.widgets")
--   widgets.centered_float(widgets.scopes)
-- end)

local adapters = require("lua.plugins.dap.adapters")
local configurations = require("lua.plugins.dap.configurations")

return {
    {
        "mfussenegger/nvim-dap",
        ft = vim.tbl_keys(configurations),
        keys = {
            {
                "<F1>",
                function() require("dap").step_over() end,
                silent = true,
                noremap = true,
                desc = "Debug step over"
            },
            {
                "<F2>",
                function() require("dap").step_into() end,
                silent = true,
                noremap = true,
                desc = "Debug step into"
            },
            {
                "<F3>",
                function() require("dap").step_out() end,
                silent = true,
                noremap = true,
                desc = "Debug step out"
            },
            {
                "<F4>",
                function() require("dap").continue() end,
                silent = true,
                noremap = true,
                desc = "Start/resume a debug session"
            },
            {
                "<F5>",
                function() require("dap").toggle_breakpoint() end,
                silent = true,
                noremap = true,
                desc = "Insert a debug breakpoint"
            },
            {
                "<F6>",
                function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
                silent = true,
                noremap = true,
                desc = "Insert a with log"
            },
            {
                "<F7>",
                function() require("dap").repl.open() end,
                silent = true,
                noremap = true,
                desc = "Open a debug REPL"
            },
            {
                "<F8>",
                function() require("dap").run_last() end,
                silent = true,
                noremap = true,
                desc = "Run last DAP thing"
            },
        },
        config = function()
            local dap = require("dap")

            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpoint" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "󰯆", texthl = "DapBreakpoint" })
            vim.fn.sign_define("DapLogPoint", { text = "󱂅", texthl = "DapLogPoint" })
            vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", numhl = "DapStopped" })

            dap.set_log_level("TRACE")

            dap.adapters = adapters
            dap.configurations = configurations
        end
    },

    {
        "rcarriga/nvim-dap-ui",
        ft = vim.tbl_keys(configurations),
        dependencies = {
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap"
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")

            dapui.setup({
                icons = {
                    collapsed = "",
                    current_frame = "",
                    expanded = ""
                },
                layouts = {
                    {
                        elements = {
                            { id = "scopes",      size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks",      size = 0.25 },
                            { id = "watches",     size = 0.25 }
                        },
                        position = "left",
                        size = 40
                    },
                    {
                        elements = {
                            { id = "repl",    size = 0.5 },
                            { id = "console", size = 0.5 }
                        },
                        position = "bottom",
                        size = 10,
                    }
                },
            })

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close({})
            end
        end
    },
}
