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

vim.pack.add({
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/leoluz/nvim-dap-go",
})

local util = require("util.load")
local configurations = require("dap-configurations")

local setup = util.once(function()
    local dap, dapui = require("dap"), require("dapui")
    local adapters = require("dap-adapters")

    vim.fn.sign_define("DapBreakpoint", { text = "󰷚", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "󰯆", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapLogPoint", { text = "󱂅", texthl = "DapLogPoint" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", numhl = "DapStopped" })

    -- dap.set_log_level("DEBUG")

    dap.adapters = adapters
    dap.configurations = configurations

    require("dap-go").setup()

    dapui.setup({
        icons = {
            collapsed = "",
            current_frame = "",
            expanded = ""
        },
        layouts = {
            {
                elements = {
                    { id = "breakpoints", size = 0.25 },
                    { id = "watches",     size = 0.5 },
                    { id = "repl",      size = 0.25 },
                    -- { id = "stacks",      size = 0.25 },
                },
                position = "right",
                size = 0.35
            },
            {
                elements = {
                    { id = "scopes",    size = 1 },
                    -- { id = "console", size = 1 }
                },
                position = "bottom",
                size = 10,
            }
        },
        controls = { enabled = false },
        render = { indent = 4 }
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
end)

vim.api.nvim_create_autocmd("FileType", {
    pattern = vim.tbl_keys(configurations),
    callback = function()
        setup()
    end
})

vim.keymap.set("n", "<F1>",
    function()
        setup()
        require("dap").step_over()
    end,
    { silent = true, noremap = true, desc = "Debug step over" })
vim.keymap.set("n", "<F2>",
    function()
        setup()
        require("dap").step_into()
    end,
    { silent = true, noremap = true, desc = "Debug step into" })
vim.keymap.set("n", "<F3>",
    function()
        setup()
        require("dap").step_out()
    end,
    { silent = true, noremap = true, desc = "Debug step out" })
vim.keymap.set("n", "<F4>",
    function()
        setup()
        require("dap").continue()
    end,
    { silent = true, noremap = true, desc = "Start/resume a debug session" })
vim.keymap.set("n", "<F5>",
    function()
        setup()
        require("dap").toggle_breakpoint()
    end,
    { silent = true, noremap = true, desc = "Insert a debug breakpoint" })
vim.keymap.set("n", "<F6>",
    function()
        setup()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end,
    { silent = true, noremap = true, desc = "Insert a with log" })
vim.keymap.set("n", "<F7>",
    function()
        setup()
        require("dapui").toggle({})
    end,
    { silent = true, noremap = true, desc = "Open a debug REPL" })
vim.keymap.set("n", "<F8>",
    function()
        setup()
        require("dap").run_last()
    end,
    { silent = true, noremap = true, desc = "Run last DAP thing" })
