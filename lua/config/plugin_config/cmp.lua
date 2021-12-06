local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

cmp.setup({

  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" })
  },

  sources = {
    -- options:
    --   name
    --   keyword_length
    --   priority
    --   (more?)
    --   max_item_count
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 3 }
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },

  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      -- maxwidth = 50,
      menu = {
        buffer = "[BF]",
        nvim_lsp = "[LSP]",
        path = "[path]",
        luasnip = "[snip]",
        nvim_lua = "[lua]",
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

-- NOTE: highlight groups
-- CmpItemAbbr
-- CmpItemAbbrDeprecated
-- CmpItemAbbrMatch
-- CmpItemAbbrMatchFuzzy
-- CmpItemKind
-- CmpItemKind%KIND_NAME%
-- CmpItemMenu

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['solargraph'].setup {
  capabilities = capabilities
}
