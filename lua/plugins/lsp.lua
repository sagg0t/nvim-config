return {
    {
        "j-hui/fidget.nvim",
        lazy = true,
        event = "LspProgress",
        opts = {},
    },

    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        ft = { "c", "cpp", "swift", "rust" },
        name = "clangd_extensions",
        dependencies = { "saghen/blink.cmp" },
        opts = {
            server = {
                capabilities = require("blink.cmp").get_lsp_capabilities(
                    vim.lsp.protocol.make_client_capabilities()
                )
            }
        }
    },

    { "neovim/nvim-lspconfig" },

    {
        "nvimtools/none-ls.nvim",
        lazy = true,
        ft = { "go" },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.code_actions.gomodifytags,
                    null_ls.builtins.code_actions.impl,

                    null_ls.builtins.formatting.goimports_reviser,
                },
            })
        end
    }
}
