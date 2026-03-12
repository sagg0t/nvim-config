vim.keymap.set("n", "<Leader>x", ":.lua<CR>", { buffer = 0 })
vim.keymap.set("v", "<Leader>x", ":lua<CR>", { buffer = 0 })
vim.keymap.set("n", "<Leader><Leader>x", ":so %<CR>", { buffer = 0 })
vim.keymap.set("n", "<Leader>X", ":fclose<CR>", { buffer = 0 })
