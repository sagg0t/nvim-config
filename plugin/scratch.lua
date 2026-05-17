vim.api.nvim_create_user_command("Scratch", function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
    local ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })

    local buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_name(buf, "Scratch")
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_set_option_value("filetype", ft, { buf = buf })
    vim.api.nvim_set_option_value("bufhidden", "delete", { buf = buf })
    vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })

    vim.api.nvim_open_win(buf, true, { split = "right" })
end, { desc = "Creates a window with a scratch buf identical to current" })
