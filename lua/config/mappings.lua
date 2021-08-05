default_opts = { noremap = true, silent = true }
-- unmap SPACE from Leader
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', default_opts)

vim.api.nvim_set_keymap('n', '<Leader>h', ':noh<CR>', default_opts)


-- better visual indenting
vim.api.nvim_set_keymap('v', '<', '<gv', default_opts)
vim.api.nvim_set_keymap('v', '>', '>gv', default_opts)
vim.api.nvim_set_keymap('n', '<C-o>', ':Ag<CR>', default_opts)
-- nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"


-- line movement
vim.api.nvim_set_keymap('n', '<C-j>', ':m .+1<CR>==', default_opts)
vim.api.nvim_set_keymap('n', '<C-k>', ':m .-2<CR>==', default_opts)


-- minmax
vim.api.nvim_set_keymap('n', '<Leader>m', ':MaximizerToggle<CR>', default_opts)
