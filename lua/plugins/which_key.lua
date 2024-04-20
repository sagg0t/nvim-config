
return {
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300

            local wk = require("which-key")

            wk.setup({})

            wk.register(
                {
                    l = { name = "LSP" },
                    f = {
                        name = "Telescope",
                        f = "find file",
                        t = "find text",
                        s = "document symbols",
                        o = "recently opened files",
                        h = "vim help",
                        k = "keymaps",
                        O = "vim options",
                        ["/"] = "current buffer fuzzy search",
                        ["?"] = "search history",
                        [";"] = "command-line history",
                        c = "execute command",
                    }
                },
                {
                    prefix = "<space>"
                }
            )
        end,
    }
}
