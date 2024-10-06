return {
    {
        "folke/which-key.nvim",
        enabled = false,
        event = "VeryLazy",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300

            local wk = require("which-key")

            wk.setup({})

            wk.add({
                {
                    mode = "n",
                    { "<Leader>f",  group = "find" },
                    { "<Leader>l",  group = "LSP" },
                    { "<Leader>t",  group = "test" },
                }
            })
        end,
    }
}
