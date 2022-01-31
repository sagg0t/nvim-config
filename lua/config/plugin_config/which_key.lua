local wk = require("which-key")

wk.setup({})

local opts = { prefix = "<space>" }
local mappings = {
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
    }
}

wk.register(mappings, opts)
