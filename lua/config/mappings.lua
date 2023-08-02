local default_opts = { noremap = true, silent = true }
-- unmap SPACE from Leader
-- vim.keymap.set('n', '<Space>', '<NOP>', default_opts)

vim.keymap.set("n", "<Leader>h", ":noh<CR>", default_opts)

-- vim.keymap.set("n", "<C-b><C-b>",   "<CMD>Explore<CR>",     default_opts)
-- vim.keymap.set("n", "<C-b>b",       "<CMD>Explore<CR>",     default_opts)
-- vim.keymap.set("n", "<C-b><C-s>",   "<CMD>Sexplore<CR>",    default_opts)
-- vim.keymap.set("n", "<C-b>s",       "<CMD>Sexplore<CR>",    default_opts)
-- vim.keymap.set("n", "<C-b><C-v>",   "<CMD>Vexplore<CR>",    default_opts)
-- vim.keymap.set("n", "<C-b>v",       "<CMD>Vexplore<CR>",    default_opts)
-- vim.keymap.set("n", "<C-b><C-t>",   "<CMD>Texplore<CR>",    default_opts)
-- vim.keymap.set("n", "<C-b>t",       "<CMD>Texplore<CR>",    default_opts)

return {}
