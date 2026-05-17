return {
    settings = {
        emmylua = {
            codeLens = { enable = true },
            documentColor = { enable = true },
            hint = {
                enable = true,
                paramHint = false,
                localHint = false,
            },
            semanticTokens = {
                enabled = false,
            },
            runtime = {
                version = "LuaJIT",
                requirePattern = { "?.lua", "?/init.lua" },
            },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                    vim.fn.stdpath("config"),
                }
            },
        }
    }
}
