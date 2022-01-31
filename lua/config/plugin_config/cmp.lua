local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

cmp.setup({
    sources = {
        -- options:
        --   name
        --   keyword_length
        --   priority
        --   max_item_count
        --   (more?)
        { name = "nvim_lua" },
        { name = "neorg" },
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" }
    },

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

    experimental = {
        native_menu = false,
        ghost_text = true
    },

    documentation = true
})

cmp.setup.cmdline(":", {
    sources = {
        { name = "cmdline" }
    }
})
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})


-- NOTE: highlight groups
-- CmpItemAbbr
-- CmpItemAbbrDeprecated
-- CmpItemAbbrMatch
-- CmpItemAbbrMatchFuzzy
-- CmpItemKind
-- CmpItemKind%KIND_NAME%
-- CmpItemMenu
