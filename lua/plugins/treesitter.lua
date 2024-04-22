return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "cmake",
                "cpp",
                "css",
                "cuda",
                "dockerfile",
                "fish",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "glsl",
                "go",
                "gomod",
                "gosum",
                "gotmpl",
                "gowork",
                "gpg",
                "graphql",
                "haskell",
                "haskell_persistent",
                "hcl",
                "hlsl",
                "html",
                "http",
                "ini",
                "java",
                "javascript",
                "jq",
                "jsdoc",
                "json",
                "latex",
                "llvm",
                "lua",
                "luadoc",
                "make",
                "markdown",
                "markdown_inline",
                "ninja",
                "odin",
                "passwd",
                "php",
                "phpdoc",
                "proto",
                "python",
                "query",
                "regex",
                "ruby",
                "rust",
                "scheme",
                "scss",
                "sql",
                "ssh_config",
                "swift",
                "terraform",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
                "zig",
            },

            synct_install = false,
            auto_install = true,

            indent = { enable = false },
            highlight = {
                enable = true, -- false will disable the whole extension
                disable = {},  -- list of language that will be disabled
                -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                --  If you are experiencing weird indenting issues, add the language to
                --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { 'ruby' },
            },

            endwise = { enable = true },
        },
        config = function(_, opts)
            require('nvim-treesitter.install').prefer_git = true
            require("nvim-treesitter.configs").setup(opts)
        end
    },

    {
        "RRethy/nvim-treesitter-endwise",
        dependencies = "nvim-treesitter/nvim-treesitter",
    },
}
