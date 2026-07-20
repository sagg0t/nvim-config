vim.api.nvim_create_user_command("UUID", function()
    local uuid = string.lower(vim.trim(vim.system({ "uuidgen" }):wait().stdout))
    vim.api.nvim_put({ uuid }, "c", true, true)
end)
