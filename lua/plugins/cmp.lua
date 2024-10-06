return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            {
                "hrsh7th/cmp-nvim-lua",
                ft = "lua"
            },
            -- "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            -- "saadparwaiz1/cmp_luasnip",
            -- "luasnip"
            "onsails/lspkind-nvim",
            -- "kristijanhusak/vim-dadbod-completion",
        },
        config = function()
            local cmp = require("cmp")
            -- local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            cmp.setup({
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    -- { name = "luasnip" },
                    { name = "path" },
                }, { { name = "buffer" } }),

                -- snippet = {
                --     expand = function(args)
                --         vim.print(args)
                --         luasnip.lsp_expand(args.body)
                --     end
                -- },
                completion = { completeopt = 'menu,menuone,fuzzy,preview,noinsert' },

                sorting = {
                    comparators = {
                        cmp.config.compare.exact,
                        cmp.config.compare.offset,
                        cmp.config.compare.score,

                        function(entry1, entry2)
                            local _, entry1_under = entry1.completion_item.label:find "^_+"
                            local _, entry2_under = entry2.completion_item.label:find "^_+"
                            entry1_under = entry1_under or 0
                            entry2_under = entry2_under or 0

                            return entry1_under < entry2_under
                        end,

                        cmp.config.compare.kind,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },

                formatting = {
                    format = function(entry, item)
                        local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })
                        item = lspkind.cmp_format({
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
                        })(entry, item)

                        if color_item.abbr_hl_group then
                                item.kind_hl_group = color_item.abbr_hl_group
                                item.kind = color_item.abbr
                        end
                        return item
                    end
                },

                mapping = {
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-y>'] = cmp.mapping.confirm { select = true },
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                },

                experimental = {
                    -- ghost_text = true
                },

                window = {
                    documentation = cmp.config.window.bordered()
                }
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "cmdline" } }
            })
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = 'buffer' } }
            })

            cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
                sources = {
                    { name = 'vim-dadbod-completion' },
                }
            })

            cmp.setup.filetype({ "lua" }, {
                sources = {
                    { name = "nvim_lua" },
                }
            })
        end
    },
}
