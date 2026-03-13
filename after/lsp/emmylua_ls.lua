return {
    settings = {
        emmylua_ls = {
            workspace = {
                library = {
                    vim.env.VIMRUNTIME .. "/lua",
                    vim.fn.stdpath("config"),
                    "${3rd}/luv/library",
                }
            },
            runtime = {
                version = "LuaJIT",
            }
        }
    }
}
