vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        {
            import = "plugins"
        },
    },
    defaults = {
        lazy = false,
        version = false,
    },
    install = { colorscheme = { "sigma", "habamax" } },
    -- checker = { enabled = true, frequency = 3600 * 6 },
    checker = { enabled = true },
    change_detection = { notify = false },
})

-- vim.api.nvim_set_keymap('n', '<Leader>dl', ":lua require('config.dbg.ruby').launch()<CR>", {})
