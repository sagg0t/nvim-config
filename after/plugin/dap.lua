-- vim.keymap.set({"n", "v"}, "<Leader>dp", function()
--   require("dap.ui.widgets").preview()
-- end)
-- vim.keymap.set("n", "<Leader>df", function()
--   local widgets = require("dap.ui.widgets")
--   widgets.centered_float(widgets.frames)
-- end)

if true then return {} end

vim.pack.add({
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/leoluz/nvim-dap-go",
}, { load = true })

vim.fn.sign_define("DapBreakpoint", {
    -- text = "󰷚",
    texthl = "DapBreakpoint",
    linehl = "DapBreakpointLine",
})
vim.fn.sign_define("DapBreakpointCondition", {
    -- text = "",
    texthl = "DapBreakpointCondition",
    linehl = "DapBreakpointConditionLine",
})
vim.fn.sign_define("DapBreakpointRejected", {
    -- text = "󰯆",
    texthl = "DapBreakpointRejected",
    linehl = "DapBreakpointRejectedLine",
})
vim.fn.sign_define("DapLogPoint", {
    -- text = "󱂅",
    texthl = "DapLogPoint",
    linehl = "DapLogPointLine",
})
vim.fn.sign_define("DapStopped", {
    -- text = "",
    texthl = "DapStopped",
    numhl = "DapStopped",
    linehl = "DapStoppedLine",
})

local util = require("util.load")
local configurations = require("dap-configurations")

local setup = util.once(function()
    -- local dap, dapui = require("dap"), require("dapui")
    local dap = require("dap")
    local adapters = require("dap-adapters")

    -- dap.set_log_level("DEBUG")

    dap.adapters = adapters
    dap.configurations = configurations

    require("dap-go").setup()

    -- dapui.setup({
    --     icons = {
    --         collapsed = "",
    --         current_frame = "",
    --         expanded = ""
    --     },
    --     expand_lines = false,
    --     force_buffers = true,
    --     layouts = {
    --         {
    --             elements = { { id = "scopes" } },
    --             position = "bottom",
    --             size = 10,
    --         },
    --         {
    --             elements = { { id = "watches" } },
    --             position = "right",
    --             size = 30
    --         },
    --     },
    --     controls = { enabled = false },
    --     render = { indent = 4 }
    -- })

    dap.defaults.fallback.switchbuf = "useopen,vsplit,uselast"

    dap.listeners.before.scopes["custom_scopes"] = function()
        vim.print("scopes before hook")
    end
    dap.listeners.after.scopes["custom_scopes"] = function()
        vim.print("scopes after hook")
    end

    -- dap.listeners.after.event_initialized["dapui_config"] = function()
    --     dapui.open(1)
    -- end
    -- dap.listeners.before.event_terminated["dapui_config"] = function()
    --     dapui.close()
    -- end
    -- dap.listeners.before.event_exited["dapui_config"] = function()
    --     dapui.close()
    -- end
end)

-- local dap_ft = vim.tbl_keys(configurations)
-- table.insert(dap_ft, "go")
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = dap_ft,
--     callback = function()
--         setup()
--     end
-- })
--
-- local map = function(lhs, desc, rhs)
--     vim.keymap.set("n", lhs, rhs, { silent = true, noremap = true, desc = desc })
-- end
--
-- map("<Leader>dr", "Run debug session", function() require("dap").continue() end)
-- map("<Leader>dn", "Step over", function() require("dap").step_over() end)
-- map("<Leader>di", "Step into", function() require("dap").step_into() end)
-- map("<Leader>do", "Step out", function() require("dap").step_out() end)
-- map("<Leader>dj", "Down", function() require("dap").down() end)
-- map("<Leader>dk", "Up", function() require("dap").up() end)
--
-- map("<Leader>db", "Set breakpoint", function() require("dap").toggle_breakpoint() end)
-- map("<Leader>dl", "Set logpoint", function()
--     require("dap").set_breakpoint(nil, nil, vim.fn.input("Log: "))
-- end)
-- map("<Leader>dc", "Set conditional breakpoint", function()
--     require("dap").set_breakpoint(vim.fn.input("Break if: "))
-- end)
-- map("<Leader>dX", "Clear all breakpoints", function() require("dap").clear_breakpoints() end)
--
-- map("<Leader>dK", "DAP Hover", function() require("dap.ui.widgets").hover() end)
-- map("<Leader>dB", "List breakpoints", function()
--     require("dap").list_breakpoints(true)
-- end)
-- map("<Leader>dL", "Run last DAP thing", function() require("dap").run_last() end)
-- -- map("<Leader>dU", "Debug UI", function()
-- --     local layouts = require("dapui.windows").layouts
-- --     local is_open = false
-- --     for _, layout in ipairs(layouts) do
-- --         if layout:is_open() then
-- --             is_open = true
-- --             break
-- --         end
-- --     end
-- --
-- --     if is_open then
-- --         require("dapui").close()
-- --     else
-- --         require("dapui").open()
-- --     end
-- -- end)
-- map("<Leader>dS", "DAP Scopes", function() require("ui.dap.scopes"):toggle() end)
-- map("<Leader>ds", "DAP Scopes [native]", (function()
--       local widgets = require("dap.ui.widgets")
--       local view = widgets.sidebar(widgets.scopes)
--       return function() view.toggle() end
-- end)())
-- map("<Leader>da", "", function()
--     local session = require("dap").session()
--     if not session then return end
--
--     vim.print(session.current_frame.scopes)
-- end)
-- -- map("<Leader>dW", "DAP Watches", function() require("dapui").toggle(2) end)
-- map("<Leader>dR", "Debug REPL", function() require("dap").repl.toggle() end)
--
-- vim.api.nvim_create_user_command("DapSetFilters", function()
--     vim.ui.select({ "none", "default", "custom" }, {
--         prompt = "Exception filter",
--     }, function(choice)
--         local filters
--
--         if choice == "none" then
--             filters = {}
--         elseif choice == "default" then
--             filters = "default"
--         else
--             vim.ui.input({ prompt = "Custom filters: " }, function(input)
--                 if not input then return end
--
--                 filters = vim.split(input, " ", { plain = true, trimempty = true })
--                 if #filters == 0 then -- treat blank string as no input
--                     filters = nil
--                 end
--             end)
--         end
--
--         if filters then
--             require("dap").set_exception_breakpoints(filters)
--         end
--     end)
-- end, {})
