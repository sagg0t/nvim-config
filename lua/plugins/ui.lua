TEST_STRING = [[opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
            },
            views = {
                mini = {
                    timeout = 4000
                }
            }
            -- routes = {
            --     {
            --         filter = {
            --             event = "msg_show",
            --             kind = "",
            --             find = "written",
            --         },
            --         opts = { skip = true },
            --     },
            -- },
        }]]
return {
    "jiangmiao/auto-pairs", -- find lua analogue
    "andrewradev/splitjoin.vim",

    {
        "szw/vim-maximizer",
        lazy = true,
        cmd = "MaximizerToggle",
        keys = {
            { '<Leader>m', ':MaximizerToggle<CR>', noremap = true, silent = true }
        }
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            show_current_context = true
        }
    },

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = { default = true }
    },

    {
        "ii14/neorepl.nvim",
    },

    {
        "folke/noice.nvim",
        -- enabled = false,
        event = "VeryLazy",
        keys = {
            { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
            { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
            { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
        },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
            },
            views = {
                mini = {
                    timeout = 4000
                }
            }
            -- routes = {
            --     {
            --         filter = {
            --             event = "msg_show",
            --             kind = "",
            --             find = "written",
            --         },
            --         opts = { skip = true },
            --     },
            -- },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },

    { "MunifTanjim/nui.nvim", lazy = true },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "TodoTrouble",
        keys = {
            { '<Leader>fn', '<CMD>TodoTrouble<CR>', noremap = true, silent = true }
        },
        opts = {
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


    { "brenoprata10/nvim-highlight-colors", lazy = true }
}
