vim.keymap.set("n", "<Leader>x", ":.lua<CR>", { buf = 0 })
vim.keymap.set("v", "<Leader>x", ":lua<CR>", { buf = 0 })
vim.keymap.set("n", "<Leader><Leader>x", ":so %<CR>", { buf = 0 })
vim.keymap.set("n", "<Leader>X", ":fclose<CR>", { buf = 0 })
