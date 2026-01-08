if vim.uv.cwd() ~= "/Users/sagg0t/.config/nvim" then return end

vim.opt.packpath:append("/Users/sagg0t/devel/nvim-plugins")
vim.cmd.packadd("dap2")

vim.keymap.set("n", "<Leader>r", function()
    vim.fs.rm(vim.fn.stdpath("log") .. "/dap.log", { force = true })
    vim.cmd(":restart e ~/.local/state/nvim/dap.log | split foo.go | vsplit main.go")
end)

--- @diagnostic disable-next-line: lowercase-global
dap = require("dap")
local log = dap.log

log.set_level(log.levels.TRACE)

vim.keymap.set("n", "<Leader>db", dap.breakpoint.toggle)
vim.keymap.set("n", "<Leader>dr", dap.session.resume)

dap.configurations.go = {
    adapter = "delve",
    request = "launch",
    name = "SAY MY NAME",
}

dap.adapters.delve = {
    type = "server",
    port = 6000,
    executable = {
        cmd = {
            "dlv", "dap",
            "-l", "127.0.0.1:6000",
            -- "--log", "--log-output", "dap",
        },
    }
}
