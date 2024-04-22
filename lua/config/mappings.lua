local default_opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", default_opts)

vim.keymap.set("n", "<C-p>", ":Explore<CR>", default_opts)

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

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Goto previous [D]iagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Goto next [D]iagnostic' })
vim.keymap.set('n', '[c', ":cprevious<CR>", { desc = 'Goto previous quickfix' })
vim.keymap.set('n', ']c', ":cnext<CR>", { desc = 'Goto next quickfix' })

return {}
