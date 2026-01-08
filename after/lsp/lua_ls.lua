local runtime_path = vim.api.nvim_get_runtime_file("", true)
table.insert(runtime_path, "${3rd}/luv/library")
table.insert(runtime_path, "${3rd}/luassert/library")
table.insert(runtime_path, "${3rd}/busted/library")
table.insert(runtime_path, 1, "/Users/sagg0t/devel/nvim-plugins/pack/core/opt/dap2")

---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                -- Tell the language server how to find Lua modules same way as Neovim
                -- (see `:h lua-module-load`)
                -- path = {
                --     "?.lua",
                --     "?/init.lua",
                -- },
                -- special = {
                --     ["vim.uv"] = "luv",
                -- }
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = "ApplyInMemory",
                -- library = {
                --   vim.env.VIMRUNTIME
                --   -- Depending on the usage, you might want to add additional paths
                --   -- here.
                --   -- "${3rd}/luv/library"
                --   -- "${3rd}/busted/library"
                -- }
                -- Or pull in all of "runtimepath".
                -- NOTE: this is a lot slower and will cause issues when working on
                -- your own configuration.
                -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                library = runtime_path
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                -- globals = { "vim", "Snacks" },
            },
            hint = {
                enable = false
            },
        },
    },
}
