return {
    {
        "szw/vim-maximizer",
        lazy = true ,
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
        config = function()
            vim.cmd.highlight("IndentLine guifg=#373C45")
            vim.cmd.highlight("IndentLineCurrent guifg=#dc3c70")
            require("indentmini").setup({})
        end
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
        cmd = {
            "TodoTelescope",
            "TodoQuickfix",
        },
        keys = {
            {
                "<Leader>fn",
                "<CMD>TodoTelescope<CR>",
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
        "brenoprata10/nvim-highlight-colors",
        lazy = true,
        cmd = { "HighlightColors" },
        opts = {
            enable_tailwind = true,
            render = "foreground"
        }
    }
}
