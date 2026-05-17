---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = { "?.lua", "?/init.lua" },
                -- special = {
                --     ["vim.uv"] = "luv",
                -- }
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = "ApplyInMemory",
                library = {
                  vim.env.VIMRUNTIME
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
