return {
    {
        "saghen/blink.cmp",
        lazy = false, -- lazy loading handled internally
        -- dependencies = "rafamadriz/friendly-snippets",
        build = "cargo build --release",

        opts = {
            highlight = {
                -- sets the fallback highlight groups to nvim-cmp's highlight groups
                -- useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release, assuming themes add support
                use_nvim_cmp_as_default = true,
            },

            trigger = {
                -- signature_help = { enabled = true },
                completion = {
                    keyword_range = "full"
                }
            },

            fuzzy = {
                use_fecency = false,
            },

            keymap = { preset = "default" },

            windows = {
                autocomplete = {
                    draw = {
                        columns = { { "kind_icon" }, { "label" } }
                    }
                --     draw = function(ctx)
                --         return {
                --             " ",
                --             { ctx.kind_icon, ctx.icon_gap, hl_group = "BlinkCmpKind" .. ctx.kind },
                --             {
                --               ctx.label,
                --               ctx.kind == "Snippet" and "~" or nil,
                --               fill = true,
                --               hl_group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
                --               max_width = 50,
                --             },
                --             " ",
                --             {
                --                 ctx.item.source,
                --                 hl_group = "@comment"
                --             },
                --             " ",
                --         }
                --     end
                },
                documentation = {
                    min_width = 15,
                    max_width = 80,
                    max_height = 40,
                    -- 'single' | 'double' | 'rounded' | 'solid' | 'shadow' | 'padded' | 'none' | string[]
                    border = "double",
                    auto_show = true
                },
            }
        }
    }
}
