---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            runtime = {
              version = "LuaJIT",
              -- Tell the language server how to find Lua modules same way as Neovim
              -- (see `:h lua-module-load`)
              path = { "lua/?.lua", "lua/?/init.lua" },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
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
              library = {
                vim.api.nvim_get_runtime_file("", true),
              }
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim", "Snacks" },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false },
        },
    },
}
