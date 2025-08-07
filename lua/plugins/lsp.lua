return {
    {
        "j-hui/fidget.nvim",
        lazy = true,
        event = "LspProgress",
        opts = {},
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
