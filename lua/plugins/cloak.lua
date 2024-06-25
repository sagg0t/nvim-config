return {
    {
        "laytan/cloak.nvim",
        enabled = false,
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
