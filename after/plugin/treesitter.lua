require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'c', 'cpp', 'cmake', 'cuda',
        'ruby', 'dockerfile', 'graphql', 'json', 'yaml', 'python', 'http',
        'javascript', 'css', 'html', 'scss', 'typescript', 'tsx',
        'lua', 'regex',
        'bash', 'fish'
    },

    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {},  -- list of language that will be disabled
        -- additional_vim_regex_highlighting = false
    },

    endwise = {
      enable = true
    }
}
