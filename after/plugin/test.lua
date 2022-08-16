local tst = require("neotest")

tst.setup({
    adapters = {
        require("neotest-rspec"),
        require("neotest-go")
    },
    output = {
        open_on_run = true
    },
    discovery = {
        enabled = false
    },
})

vim.keymap.set("n", "<Leader>tn", tst.run.run, { silent = false })

vim.keymap.set("n",
               "<Leader>tf",
               function()
                   require("neotest").run.run(vim.fn.expand("%"))
               end,
               { silent = false })

vim.keymap.set("n", "<Leader>ta", tst.run.attach, { silent = false })
vim.keymap.set("n", "<Leader>ts", tst.summary.toggle, { silent = false })
