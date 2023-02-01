-- NOTE: highlight groups
-- CmpItemAbbr
-- CmpItemAbbrDeprecated
-- CmpItemAbbrMatch
-- CmpItemAbbrMatchFuzzy
-- CmpItemKind
-- CmpItemKind%KIND_NAME%
-- CmpItemMenu

return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "lspkind-nvim",
            "luasnip"
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            cmp.setup({
                sources = cmp.config.sources({
                    -- options:
                    --   name
                    --   keyword_length
                    --   priority
                    --   max_item_count
                    --   (more?)
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = 'nvim_lsp_signature_help' },
                    { name = "path" }
                }, { { name = "buffer" } }),

                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },

                formatting = {
                    format = lspkind.cmp_format({
                        with_text = true,
                        maxwidth = 50,
                        menu = {
                            nvim_lua = "[lua]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[snip]",
                            path = "[path]",
                            buffer = "[BF]",
                            latex_symbols = "[latex]",
                        },
                    })
                },

                mapping = cmp.mapping.preset.insert(),

                experimental = {
                    ghost_text = true
                },

                -- view = {
                --     entries = "native"
                -- },

                window = {
                    documentation = cmp.config.window.bordered()
                }
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "cmdline" }
                }
            })
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
        end
    },
}
