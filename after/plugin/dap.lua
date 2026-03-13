vim.opt.packpath:append("/Users/sagg0t/devel/nvim-plugins")
vim.cmd.packadd("nvim-debugger")

if vim.uv.cwd() == "/Users/sagg0t/.config/nvim" then
    vim.keymap.set("n", "<Leader>r", function()
        vim.fs.rm(vim.fn.stdpath("log") .. "/nvim-debugger.log", { force = true })
        -- vim.cmd(":restart e ~/.local/state/nvim/nvim-debugger.log | split foo.go | vsplit main.go")
        -- vim.cmd(":restart e ~/.local/state/nvim/nvim-debugger.log | split main.go")
        vim.cmd(":restart e main.go")
    end)
end

D = require("debugger")
local log = D.log

log.set_level(log.levels.TRACE)

D.configurations.go = {
    adapter = "delve",
    request = "launch",
    name = "SAY MY NAME",
    arguments = {
        program = "/Users/sagg0t/.config/nvim",
        outputMode = "remote"
    }
}

D.adapters.delve = {
    type = "server",
    port = 6000,
    executable = {
        cmd = {
            "dlv", "dap",
            "-l", "127.0.0.1:6000",
            -- "-r", "stdout:remote",
            -- "--log", "--log-output", "dap",
        },
    }
}

vim.keymap.set("n", "<Leader>db", D.breakpoint.toggle)
vim.keymap.set("n", "<Leader>dam", function()
    D.breakpoint.set({ logMessage = D.PromptMe })
end)
vim.keymap.set("n", "<Leader>dac", function()
    D.breakpoint.set({
        logMessage = D.PromptMe,
        condition = D.PromptMe,
        hitCondition = D.PromptMe,
    })
end)
vim.keymap.set("n", "<Leader>daf", function()
    D.breakpoint.fn.set({ name = D.PromptMe })
end)
vim.keymap.set("n", "<Leader>dad", function()
    D.breakpoint.data.set({
        dataId = D.PromptMe,
        accessType = D.PromptMe,
    })
end)
vim.keymap.set("n", "<Leader>dai", function()
    D.breakpoint.data.set({
        instructionReference = D.PromptMe,
        offset = D.PromptMe,
        mode = D.PromptMe,
    })
end)
vim.keymap.set("n", "<Leader>de", D.breakpoint.enable)

vim.keymap.set("n", "<Leader>dr", D.session.resume)

vim.keymap.set("n", "<Leader>dn", D.navigation.next)
vim.keymap.set("n", "<Leader>dp", D.navigation.prev)
vim.keymap.set("n", "<Leader>di", D.navigation.step_in)
vim.keymap.set("n", "<Leader>do", D.navigation.step_out)
vim.keymap.set("n", "<Leader>dk", function() D.navigation.stack_frame_jump({ count = 1 }) end)
vim.keymap.set("n", "<Leader>dj", function() D.navigation.stack_frame_jump({ count = -1 }) end)
vim.keymap.set("n", "<Leader>dh", function() D.navigation.stack_frame_jump({ count = "top" }) end)
vim.keymap.set("n", "<Leader>dl", function() D.navigation.stack_frame_jump({ count = "bot" }) end)

vim.keymap.set("n", "<Leader>du", D.ui.toggle)
