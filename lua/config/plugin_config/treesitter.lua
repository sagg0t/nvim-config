local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}

parser_configs.norg_meta = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
        files = { "src/parser.c" },
        branch = "main"
    },
}

parser_configs.norg_table = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
        files = { "src/parser.c" },
        branch = "main"
    },
}

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
