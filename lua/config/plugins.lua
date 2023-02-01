local a = {
    function()
        use "xiyaowong/nvim-transparent"

        use { "ellisonleao/glow.nvim" }
        -- use {
        --     "NTBBloodbath/rest.nvim",
        --     requires = { "nvim-lua/plenary.nvim" }
        -- }

        use "tjdevries/colorbuddy.nvim"
        use "brenoprata10/nvim-highlight-colors"


        use "folke/trouble.nvim"
        use { "folke/which-key.nvim" }
        use {
            "folke/zen-mode.nvim",
            config = function()
                require("zen-mode").setup {
                    -- your configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                }
            end
        }

        use {
            "nvim-neotest/neotest",
            -- "~/dev/neotest",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-treesitter/nvim-treesitter",
                "antoinemadec/FixCursorHold.nvim",
                "olimorris/neotest-rspec",
                -- "~/dev/neotest-rspec",
                "~/dev/neotest-go"
            }
        }
        use({
            "andythigpen/nvim-coverage",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("coverage").setup({})
            end,
        })
        use "MTDL9/vim-log-highlighting"
        use "mfussenegger/nvim-dap"
        use "rcarriga/nvim-dap-ui"
        use "~/dev/nvim-dap-ruby"
        use "jbyuki/one-small-step-for-vimkind"


        -- slow, need alternative
        use "tpope/vim-dadbod"
        use "kristijanhusak/vim-dadbod-ui"
    end,

    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end
        },
        git = { default_url_format = "git@github.com:%s" }
    }
}
return {}
