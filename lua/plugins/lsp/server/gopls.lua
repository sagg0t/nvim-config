return {
    gopls = {
        cmd = { "gopls", "serve" },
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true
            }
        }
    }
}
