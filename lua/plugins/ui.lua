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
        "lukas-reineke/indent-blankline.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        main = "ibl",
        opts = {
            indent = {
                char = { "│" },
            },
            scope = {
                show_start = false,
                show_end = false,
            }
        }
    },

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = { default = true }
    },

    {
        "folke/todo-comments.nvim",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "TodoTrouble",
        keys = {
            { "<Leader>fn", "<CMD>TodoTrouble<CR>", noremap = true, silent = true }
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
        "brenoprata10/nvim-highlight-colors",
        lazy = true,
        cmd = {
            "HighlightColorsOn",
            "HighlightColorsOff",
            "HighlightColorsToggle",
        },
        opts = {
            enable_tailwind = true,
            render = "foreground"
        }
    }
}
