return {
    {
        "szw/vim-maximizer",
        lazy = true,
        cmd = "MaximizerToggle",
        keys = {
            {
                "<Leader>m",
                ":MaximizerToggle<CR>",
                noremap = true,
                silent = true,
                desc = "Maximizer"
            }
        }
    },

    {
        "nvimdev/indentmini.nvim",
        event = "VeryLazy",
        opts = {}
    },

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = { default = true }
    },

    {
        "folke/todo-comments.nvim",
        lazy = true,
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = {
            "TodoQuickfix",
            "TodoFzfLua"
        },
        keys = {
            {
                "<Leader>fn",
                "<CMD>TodoFzfLua<CR>",
                noremap = true,
                silent = true,
                desc = "Workspace TODO comments"
            }
        },
        opts = {
            signs = false,
            search = {
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--glob=!node_modules",
                    "--glob=!vendor/bundle",
                    "--glob=!.git",
                }
            }
        }
    },

    {
        "kylechui/nvim-surround",
        lazy = true,
        event = "VeryLazy",
        opts = {}
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },

    {
        "Wansmer/treesj",
        lazy = true,
        keys = {
            { "gs", function() require("treesj").toggle() end },
            { "gS", function() require("treesj").toggle({ split = { recursive = true } }) end },
        },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            use_default_keymaps = false,
            max_join_length = 1000
        }
    },

    {
        "ThePrimeagen/git-worktree.nvim",
        lazy = true
    },
}
