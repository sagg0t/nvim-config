-- NOTE: highlight groups
-- CmpItemAbbr
-- CmpItemAbbrDeprecated
-- CmpItemAbbrMatch
-- CmpItemAbbrMatchFuzzy
-- CmpItemKind
-- CmpItemKind%KIND_NAME%
-- CmpItemMenu

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = 'nvim_lsp_signature_help' },
                    { name = "path" }
                }, { { name = "buffer" } }),

                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },

                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,

                        function(entry1, entry2)
                            local _, entry1_under = entry1.completion_item.label:find "^_+"
                            local _, entry2_under = entry2.completion_item.label:find "^_+"
                            entry1_under = entry1_under or 0
                            entry2_under = entry2_under or 0

                            if entry1_under > entry2_under then
                                return false
                            elseif entry1_under < entry2_under then
                                return true
                            end
                        end,

                        cmp.config.compare.kind,
                        -- cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
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
                -- mapping = vim.tbl_extend('force', cmp.mapping.preset.insert(), {
                --     ["<Tab>"] = cmp.mapping(function(fallback)
                --         if cmp.visible() then
                --             cmp.select_next_item()
                --         elseif luasnip.expand_or_locally_jumpable() then
                --             luasnip.expand_or_jump()
                --         elseif has_words_before() then
                --             cmp.complete()
                --         else
                --             fallback()
                --         end
                --     end, { "i", "s" }),
                --
                --     ["<S-Tab>"] = cmp.mapping(function(fallback)
                --         if cmp.visible() then
                --             cmp.select_prev_item()
                --         elseif luasnip.jumpable(-1) then
                --             luasnip.jump(-1)
                --         else
                --             fallback()
                --         end
                --     end, { "i", "s" }),
                -- }),

                experimental = {
                    -- ghost_text = true
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
