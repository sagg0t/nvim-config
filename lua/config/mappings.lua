local default_opts = { noremap = true, silent = true }
-- unmap SPACE from Leader
-- vim.keymap.set('n', '<Space>', '<NOP>', default_opts)

vim.keymap.set('n', '<Leader>h', ':noh<CR>', default_opts)

return {}
