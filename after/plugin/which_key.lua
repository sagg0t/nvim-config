local wk = require("which-key")

wk.setup({})

wk.register(
    {
        l = {
            name = "LSP",
            d = "Goto definition",
            D = "Goto declaration",
            i = "Goto implementation",
            f = "Formating",
            h = "Hover/doc",
            s = "Signature",
            r = "Rename",
            e = "Diagnostics pop-up",
        },
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
