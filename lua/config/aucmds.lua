local g = vim.api.nvim_create_augroup("sagg0t", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = g,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 50,
        })
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = g,
    command = [[%s/\s\+$//e]],
    desc = "removes trailing whitespace"
})
