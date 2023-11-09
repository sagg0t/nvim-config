local default_opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Leader>h", ":noh<CR>", default_opts)

vim.keymap.set("n", "<C-b><C-b>",   ":Explore<CR>",     default_opts)
vim.keymap.set("n", "<C-b>b",       ":Explore<CR>",     default_opts)
vim.keymap.set("n", "<C-b><C-s>",   ":Sexplore<CR>",    default_opts)
vim.keymap.set("n", "<C-b>s",       ":Sexplore<CR>",    default_opts)
vim.keymap.set("n", "<C-b><C-v>",   ":Vexplore<CR>",    default_opts)
vim.keymap.set("n", "<C-b>v",       ":Vexplore<CR>",    default_opts)
vim.keymap.set("n", "<C-b><C-t>",   ":Texplore<CR>",    default_opts)
vim.keymap.set("n", "<C-b>t",       ":Texplore<CR>",    default_opts)


vim.keymap.set("n", "<M-h>", "<<")
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==")
vim.keymap.set("n", "<M-l>", ">>")

vim.keymap.set("i", "<M-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<M-k>", "<Esc>:m .-2<CR>==gi")

vim.keymap.set("v", "<M-h>", "<gv")
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<M-l>", ">gv")

return {}
