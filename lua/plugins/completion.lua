return {
    {
        "saghen/blink.cmp",
        lazy = false, -- lazy loading handled internally
        build = "cargo build --release",
        dependencies = {
            "onsails/lspkind-nvim",
        },

        opts = {
            fuzzy = { use_frecency = false },
            keymap = { preset = "default" },
            signature = {
                enabled = false,
                window = {
                    show_documentation = true
                }
            },

            completion = {
                keyword = {
                    range = "full",
                },

                documentation = {
                    auto_show = true,
                    window = {
                        min_width = 15,
                        max_width = 80,
                        max_height = 40,
                        -- 'single' | 'double' | 'rounded' | 'solid' | 'shadow' | 'padded' | 'none' | string[]
                        border = "double",
                    }
                },

                menu = {
                    auto_show = true,
                    draw = {
                        columns = { { "kind_icon" }, { "label" } },
                        padding = { 0, 1 },
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
                                end
                            }
                        }
                    }
                    -- draw = function(ctx)
                    --     return {
                    --         " ",
                    --         { ctx.kind_icon, ctx.icon_gap, hl_group = "BlinkCmpKind" .. ctx.kind },
                    --         {
                    --           ctx.label,
                    --           ctx.kind == "Snippet" and "~" or nil,
                    --           fill = true,
                    --           hl_group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
                    --           max_width = 50,
                    --         },
                    --         " ",
                    --         {
                    --             ctx.item.source,
                    --             hl_group = "@comment"
                    --         },
                    --         " ",
                    --     }
                    -- end
                },

                ghost_text = { enabled = false },
            },

            sources = {
                default = { "lsp", "path", "snippets", "buffer", "lazydev" },
                per_filetype = { "lazydev", "lua" },
                providers = {
                    snippets = { score_offset = -3 },
                    buffer = { score_offset = -4 },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        fallbacks = { "lsp" }
                    },
                }
            },
        }
    }
}
