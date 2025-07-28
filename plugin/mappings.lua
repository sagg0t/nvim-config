local default_opts = { noremap = true, silent = true }

local map = vim.keymap.set

map("n", "<Esc>", ":nohlsearch<CR>", default_opts)

map("n", "<C-p>", ":Explore<CR>", default_opts)

map("n", "<M-h>", "<<")
map("n", "<M-j>", ":m .+1<CR>==")
map("n", "<M-k>", ":m .-2<CR>==")
map("n", "<M-l>", ">>")

map("i", "<M-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<M-k>", "<Esc>:m .-2<CR>==gi")

map("v", "<M-h>", "<gv")
map("v", "<M-j>", ":m '>+1<CR>gv=gv")
map("v", "<M-k>", ":m '<-2<CR>gv=gv")
map("v", "<M-l>", ">gv")

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
