return {
    gopls = {
        cmd = { "gopls", "serve" },
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                    unreachable = true,
                },
                staticcheck = true,
            }
        }
    }
}
