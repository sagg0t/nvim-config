require("config.globals")

vim.g.mapleader = " "

require("config.mappings")
require("config.settings")
require("config.plugins")
require("config.colorscheme")

-- vim.api.nvim_set_keymap('n', '<Leader>dl', ":lua require('config.dbg.ruby').launch()<CR>", {})
