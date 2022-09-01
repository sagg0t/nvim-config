-- ensure packer is installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.api.nvim_command "packadd packer.vim"
end
-----------------------------

return require("packer").startup({
    function()
        use "wbthomason/packer.nvim"

        -- use {
        --     "folke/tokyonight.nvim",
        --     requires = { "lukas-reineke/indent-blankline.nvim" }
        -- }
        -- use {
        --     "Mofiqul/vscode.nvim",
        --     config = function()
        --         require('vscode').setup({
        --             transparent = false,
        --             italic_comments = true,
        --             disable_nvimtree_bg = true
        --         })
        --     end
        -- }
        use "~/dev/cs/sigma"
        -- use "~/dev/cs/roshnivim-cs"
        -- use "ellisonleao/gruvbox.nvim"
        -- use "RRethy/nvim-base16"
        -- use "rebelot/kanagawa.nvim"
        -- use "sainnhe/sonokai"
        -- use "martinsione/darkplus.nvim"
        use "B4mbus/oxocarbon-lua.nvim"

        use "xiyaowong/nvim-transparent"

        use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", }
        use { "nvim-treesitter/playground" }

        use "RRethy/nvim-treesitter-endwise"
        use { "lukas-reineke/indent-blankline.nvim", }
        use {
            "kevinhwang91/nvim-ufo",
            requires = 'kevinhwang91/promise-async'
        }
        use { "ellisonleao/glow.nvim" }
        -- use {
        --     "NTBBloodbath/rest.nvim",
        --     requires = { "nvim-lua/plenary.nvim" }
        -- }

        use "tjdevries/colorbuddy.nvim"
        use "brenoprata10/nvim-highlight-colors"
        use {
            "kyazdani42/nvim-web-devicons",
            config = function()
                require("nvim-web-devicons").setup({
                    default = true,
                })
            end
        }

        use { "williamboman/mason.nvim" }
        use { "williamboman/mason-lspconfig.nvim" }

        use "neovim/nvim-lspconfig"
        use "jose-elias-alvarez/null-ls.nvim"
        use "j-hui/fidget.nvim"
        use "onsails/lspkind-nvim"
        use "p00f/clangd_extensions.nvim"


        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-nvim-lua"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-path"
        use "hrsh7th/nvim-cmp"
        use "hrsh7th/cmp-cmdline"
        use "saadparwaiz1/cmp_luasnip"

        use "L3MON4D3/LuaSnip"
        use "rafamadriz/friendly-snippets"

        use "kyazdani42/nvim-tree.lua"

        use "hoob3rt/lualine.nvim"
        use {
            "SmiteshP/nvim-navic",
            requires = "neovim/nvim-lspconfig"
        }
        use "folke/trouble.nvim"
        use "rcarriga/nvim-notify"
        use { "folke/which-key.nvim" }
        use {
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim"
        }
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
            "nvim-telescope/telescope.nvim",
            requires = {
                { "nvim-lua/popup.nvim" },
                { "nvim-lua/plenary.nvim" }
            }
        }
        use { "nvim-telescope/telescope-dap.nvim", requires = "nvim-telescope/telescope.nvim" }
        use { "nvim-telescope/telescope-ui-select.nvim", requires = "nvim-telescope/telescope.nvim" }
        use { "nvim-telescope/telescope-media-files.nvim", requires = "nvim-telescope/telescope.nvim" }
        use { "nvim-telescope/telescope-fzf-native.nvim", run = "make", requires = "nvim-telescope/telescope.nvim" }
        use { "nvim-telescope/telescope-fzf-writer.nvim", requires = "nvim-telescope/telescope.nvim" }

        use "sindrets/diffview.nvim"
        use {
            "lewis6991/gitsigns.nvim",
            requires = {
                "nvim-lua/plenary.nvim"
            }
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


        -- use "jbyuki/venn.nvim" -- graphs
        -- use "jbyuki/nabla.nvim" -- math formulas not set up


        use "szw/vim-maximizer"
        use "jiangmiao/auto-pairs" -- find lua analogue
        use {
            "kylechui/nvim-surround",
            config = function()
                require("nvim-surround").setup({})
            end
        }
        use "andrewradev/splitjoin.vim"
        use {
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end
        }


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
})
