local default_opts = { noremap = true, silent = true }
-- unmap SPACE from Leader
-- vim.keymap.set('n', '<Space>', '<NOP>', default_opts)

vim.keymap.set('n', '<Leader>h', ':noh<CR>', default_opts)


-- better visual indenting
vim.keymap.set('v', '<', '<gv', default_opts)
vim.keymap.set('v', '>', '>gv', default_opts)


-- line movement
vim.keymap.set('n', '<C-j>', ':m .+1<CR>==', default_opts)
vim.keymap.set('n', '<C-k>', ':m .-2<CR>==', default_opts)


-- minmax
vim.keymap.set('n', '<Leader>m', ':MaximizerToggle<CR>', default_opts)

vim.keymap.set('n', '<Leader>fn', ':TodoTrouble<CR>', default_opts)

return {}
