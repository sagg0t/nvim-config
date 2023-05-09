return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = "BufReadPost",
        opts = {
            ensure_installed = {
                'c', 'cpp', 'cmake', 'cuda', 'go',
                'ruby', 'dockerfile', 'graphql', 'json', 'yaml', 'python', 'http',
                'javascript', 'css', 'html', 'scss', 'typescript', 'tsx',
                'lua', 'regex', 'bash', 'fish', 'php', 'terraform'<
                'markdown', 'markdown_inline'
            },

            highlight = {
                enable = true, -- false will disable the whole extension
                disable = {},  -- list of language that will be disabled
                -- additional_vim_regex_highlighting = false
            },

            endwise = {
              enable = true
            }
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end
    },

    {
        "nvim-treesitter/playground",
        dependencies = { "nvim-treesitter/nvim-treesitter" }
    }
}
