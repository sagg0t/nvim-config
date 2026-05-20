if false then
    require("dap_old")
    return
end

vim.opt.packpath:append(vim.env.HOME .. "/devel/nvim-plugins")
vim.cmd.packadd("nvim-debugger")

local log = require("debugger.log")
log.set_level(log.level.DEBUG)
D = require("debugger")

D.setup({
    layers = {
        -- ["nvim-debugger.float-widgets"] = false,
        -- ["nvim-debugger.breakpoints-widget"] = false,
        -- ["nvim-debugger.variables-widget"] = false,
        -- ["nvim-debugger.modules-widget"] = false,
        -- ["nvim-debugger.watch-widget"] = false,
        ["nvim-debugger.output-widget"] = {
            combined = false,
        },
    }
})

D.configurations.go = {
    {
        name = "SAY MY NAME",
        adapter = "delve",
        mode = "launch",
        arguments = {
            program = "${cwd}",
            outputMode = "remote"
        }
    }
}

D.adapters.delve = {
    pipe = { name = "/tmp/${pipe}" },
    -- tcp = { port = "${port}" },
    spawn = {
        cmd = {
            "dlv", "dap", "-l", "unix:/tmp/${pipe}",
            -- "--log", "--log-output", "dap",
        },
    }
}

local a = D.action

vim.keymap.set("n", "<Leader>db", a.breakpoint.toggle)
vim.keymap.set("n", "<Leader>dam", function()
    a.breakpoint.set({ logMessage = D.PromptMe })
end)
vim.keymap.set("n", "<Leader>dac", function()
    a.breakpoint.set({
        logMessage = D.PromptMe,
        condition = D.PromptMe,
        hitCondition = D.PromptMe,
    })
end)
vim.keymap.set("n", "<Leader>daf", function()
    a.breakpoint.fn.set({ name = D.PromptMe })
end)
vim.keymap.set("n", "<Leader>dad", function()
    a.breakpoint.data.set({
        dataId = D.PromptMe,
        accessType = D.PromptMe,
    })
end)
vim.keymap.set("n", "<Leader>dai", function()
    a.breakpoint.instruction.set({
        instructionReference = D.PromptMe,
        offset = D.PromptMe,
        mode = D.PromptMe,
    })
end)
vim.keymap.set("n", "<Leader>dae", a.breakpoint.catch)
vim.keymap.set("n", "<Leader>de", a.breakpoint.enable)
vim.keymap.set("n", "<Leader>dX", a.breakpoint.clear)

vim.keymap.set("n", "<Leader>dr", a.session.resume)

vim.keymap.set("n", "<Leader>dn", a.navigation.next)
vim.keymap.set("n", "<Leader>dp", a.navigation.prev)
vim.keymap.set("n", "<Leader>di", a.navigation.step_in)
vim.keymap.set("n", "<Leader>do", a.navigation.step_out)
vim.keymap.set("n", "<Leader>dk", function() a.navigation.stack_frame_jump({ count = 1 }) end)
vim.keymap.set("n", "<Leader>dj", function() a.navigation.stack_frame_jump({ count = -1 }) end)
vim.keymap.set("n", "<Leader>dh", function() a.navigation.stack_frame_jump({ count = "top" }) end)
vim.keymap.set("n", "<Leader>dl", function() a.navigation.stack_frame_jump({ count = "bot" }) end)

vim.keymap.set("n", "dK", a.ui.hover)
vim.keymap.set("n", "<Leader>du", a.ui.toggle)
vim.keymap.set("n", "<Leader>df", a.ui.float)
