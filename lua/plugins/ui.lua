return {
    "szw/vim-maximizer",
    "jiangmiao/auto-pairs", -- find lua analogue
    "andrewradev/splitjoin.vim",

    {
        "lukas-reineke/indent-blankline.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            show_current_context = true
        }
    },

    {
        "kyazdani42/nvim-web-devicons",
        lazy = true,
        opts = { default = true }
    },

    {
        "folke/noice.nvim",
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
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
          },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },

    { "MunifTanjim/nui.nvim", lazy = true },

    {
        "folke/todo-comments.nvim",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim"
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
    }
}
