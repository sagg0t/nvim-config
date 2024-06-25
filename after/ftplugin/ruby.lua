local set = vim.opt_local

set.shiftwidth = 2
set.tabstop = 2
set.softtabstop = 2

vim.api.nvim_set_hl(0, "@lsp.type.namespace.ruby", { link = "Type" })
