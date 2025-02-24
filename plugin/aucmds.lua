local yank_group = vim.api.nvim_create_augroup("sagg0t TextYankPost", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.hl.on_yank({
            higroup = "IncSearch",
            timeout = 69,
        })
    end,
})

-- local pre_write_group = vim.api.nvim_create_augroup("sagg0t BufWritePre", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group = pre_write_group,
--     command = [[%s/\s\+$//e]],
--     desc = "removes trailing whitespace"
-- })
