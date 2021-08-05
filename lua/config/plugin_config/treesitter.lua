-------------------------------------------------------
--------------------  TREESITTER  ---------------------
-------------------------------------------------------

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'c', 'cpp', 'cmake', 'cuda',
    'ruby', 'dockerfile', 'graphql', 'json', 'yaml', 'python',
    'javascript', 'css', 'html', 'scss', 'typescript', 'tsx',
    'lua', 'regex',
    'bash',
  },

  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
}
