return {
    {
        "laytan/cloak.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {
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
        }
    }
}
