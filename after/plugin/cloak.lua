vim.pack.add({
    "https://github.com/laytan/cloak.nvim",
})

local util = require("util.load")

util.on_ui_enter(function()
    require("cloak").setup({
        enabled = true,
        cloak_character = "*",
        patterns = {
            {
                file_pattern = {
                    ".env*",
                    "wrangler.toml",
                    ".dev.vars",
                },
                cloak_pattern = { "=.+", ":.+", "-.+" }
            }
        }
    })
end)
