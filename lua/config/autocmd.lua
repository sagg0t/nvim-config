vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.cmd([[highlight NormalFloat guibg=#1f2335]])
        vim.cmd([[highlight FloatBorder guifg=white guibg=#fff]])
    end
})
