vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-neotest/nvim-nio",
}, { load = true })

if vim.uv.fs_stat(".nvim.lua") then
    require("util.load").on_ui_enter(function()
        local trusted = vim.secure.read(".nvim.lua")
        assert(loadstring(trusted, "@" .. ".nvim.lua"))()
    end)
end
