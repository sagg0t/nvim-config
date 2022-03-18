require('config.plugins')
require('config.settings')
require('config.mappings')
require('config.highlights')

require('config.plugin_config.cmp')
require('config.plugin_config.lualine')
require('config.plugin_config.nvim_tree')
require('config.plugin_config.telescope')
require('config.plugin_config.treesitter')
require('config.plugin_config.test')
require('config.plugin_config.tokyonight')
require('config.plugin_config.trouble')
require('config.plugin_config.snippets')
require('config.plugin_config.nvim_lsp')
require('config.plugin_config.dap')
require('config.plugin_config.git')
require('config.plugin_config.which_key')

-- require('sql')



vim.api.nvim_set_keymap('n', '<Leader>dl', ":lua require('config.dbg.ruby').launch()<CR>", {})
