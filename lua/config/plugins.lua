-- ensure packer is installed
local install_path = vim.fn.stdpath("data").."/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.api.nvim_command "packadd packer.vim"
end
-----------------------------

return require("packer").startup({
    function()
        use "wbthomason/packer.nvim"

        use "dunstontc/vim-vscode-theme"
        use "folke/tokyonight.nvim"
        use "Mofiqul/vscode.nvim"
        use "shaeinst/roshnivim-cs"

        use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", }
        use { "nvim-treesitter/playground" }
        use "RRethy/nvim-treesitter-endwise"
        use {
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require("indent_blankline").setup({
                    show_current_context = true
                })
            end
        }
        use { "rrethy/vim-hexokinase", run = "make hexokinase" } -- highlight hex colors

        use "onsails/lspkind-nvim"
        use "tjdevries/colorbuddy.nvim"
        use {
            "kyazdani42/nvim-web-devicons",
            config = function()
                require("nvim-web-devicons").setup({
                    default = true,
                })

            end
        }

        use "neovim/nvim-lspconfig"
        use "j-hui/fidget.nvim"

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
        -- use {
        --     "ms-jpq/chadtree",
        --     branch = "chad",
        --     run = "python3 -m chadtree deps"
        -- }
        use "hoob3rt/lualine.nvim"
        use {
            "SmiteshP/nvim-gps",
            requires = "nvim-treesitter/nvim-treesitter"
        }
        use "folke/trouble.nvim"
        use "rcarriga/nvim-notify"
        use {
            "folke/which-key.nvim",
            config = function() require("which-key").setup({}) end
        }
        use {
          "folke/todo-comments.nvim",
          requires = "nvim-lua/plenary.nvim",
          config = function()
              require("todo-comments").setup({})
          end
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
                {"nvim-lua/popup.nvim"},
                {"nvim-lua/plenary.nvim"},
                {"nvim-telescope/telescope-fzf-native.nvim", run = "make" }
            }
        }
        use { "nvim-telescope/telescope-dap.nvim" }
        use { "nvim-telescope/telescope-ui-select.nvim" }
        use { "nvim-telescope/telescope-media-files.nvim" }

        -- use {
        --     "TimUntersberger/neogit",
        --     requires = {
        --         "nvim-lua/plenary.nvim",
        --         "sindrets/diffview.nvim"
        --     }
        -- }
        use "sindrets/diffview.nvim"
        use {
            "lewis6991/gitsigns.nvim",
            requires = {
                "nvim-lua/plenary.nvim"
            }
        }


        use {
            "rcarriga/vim-ultest",
            requires = {"vim-test/vim-test"},
            run = ":UpdateRemotePlugins",
        }
        use "mfussenegger/nvim-dap"
        use "rcarriga/nvim-dap-ui"


        use "jbyuki/venn.nvim" -- graphs
        use "jbyuki/nabla.nvim" -- math formulas not set up


        use "szw/vim-maximizer"
        use "jiangmiao/auto-pairs" -- find lua analogue
        use "tpope/vim-surround"
        use "andrewradev/splitjoin.vim"
        use {
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end
        }
        -- use "vimwiki/vimwiki"
        use { "jgdavey/tslime.vim", branch = "main" }


        -- slow, need alternative
        use "tpope/vim-dadbod"
        use "kristijanhusak/vim-dadbod-ui"
    end,
    config = {
        display = {
            open_fn = function() return require("packer.util").float({ border = "single" }) end
        }
    }
})
