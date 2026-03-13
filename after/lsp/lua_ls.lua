---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                -- Tell the language server how to find Lua modules same way as Neovim
                -- (see `:h lua-module-load`)
                path = {
                    "?.lua",
                    "?/init.lua",
                },
                -- special = {
                --     ["vim.uv"] = "luv",
                -- }
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = "ApplyInMemory",
                library = {
                  vim.env.VIMRUNTIME
                  -- Depending on the usage, you might want to add additional paths
                  -- here.
                  -- "${3rd}/luv/library"
                  -- "${3rd}/busted/library"
                }
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                -- globals = { "vim", "MiniPick" },
            },
            completion = {
                displayContext = 20,
                showWord = "Enable",
            },
            hint = { enable = false },
            hover = {
                expandAlias = false,
            },
            type = {
                checkTableShape = true,
                inferParamType = true,
            },
        },
    },
}
