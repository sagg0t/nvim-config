return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
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
            require("nvim-treesitter.configs").setup(opts)

            local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
            parser_configs.gotmpl = {
                install_info = {
                    -- url = "https://github.com/olehvolynets/tree-sitter-go-template",
                    url = "~/devel/tree-sitter-go-template",
                    files = { "src/parser.c" },
                },
                filetype = "gotmpl",
                used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "html", "yaml", "text" }
            }
        end
    },

    {
        "nvim-treesitter/playground",
        dependencies = { "nvim-treesitter/nvim-treesitter" }
    },
}
