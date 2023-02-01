--[[
    TelescopeSelection          selected item
    TelescopeSelectionCaret     selection caret
    TelescopeMultiSelection     multisections
    TelescopeNormal             floating windows created by telescope.

                    Border highlight groups.
    TelescopeBorder
    TelescopePromptBorder
    TelescopeResultsBorder
    TelescopePreviewBorder

    TelescopeMatching           Used for highlighting characters that you match.
    TelescopePromptPrefix       Used for the prompt prefix
--]]


return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        keys = {
            { "<Leader>ff", "<CMD>Telescope find_files<CR>" },
            { "<Leader>ft", "<CMD>Telescope live_grep<CR>" },
            { "<Leader>fs", "<CMD>Telescope lsp_document_symbols<CR>" },
            { '<Leader>fo', '<CMD>Telescope oldfiles<CR>' },
            { '<Leader>fh', '<CMD>Telescope help_tags<CR>' },
            { '<Leader>fk', '<CMD>Telescope keymaps<CR>' },
            { '<Leader>fO', '<CMD>Telescope vim_options<CR>' },
            { '<Leader>f/', '<CMD>Telescope current_buffer_fuzzy_find<CR>' },
            { '<Leader>f?', '<CMD>Telescope search_history<CR>' },
            { '<Leader>f;', '<CMD>Telescope command_history<CR>' },
            { '<Leader>fc', '<CMD>Telescope commands<CR>' }
        },
        dependencies = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" }
        },
        opts = {
            defaults = {
                winblend = 10,
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                -- layout_strategy = "horizontal",
                file_ignore_patterns = { "node_modules" },
                -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            },


            pickers = {
                live_grep = {
                    theme = 'dropdown',
                    prompt_title = "Search",
                    results_title = '',
                    preview_title = '',
                    layout_config = {
                        width = 0.85,
                    }
                },
                find_files = {
                    layout_strategy = "center",
                    prompt_title = "Search",
                    layout_config = {
                        width = function(_, max_columns, _)
                            return math.min(max_columns - 3, 80)
                        end,
                        height = function(_, _, max_lines)
                            return math.min(max_lines - 4, 30)
                        end,
                    },
                },
            },


            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true
                },
                fzf_writer = {
                    use_highlighter = true
                },
            }
        },
        config = function(_, opts)
            local telescope = require("telescope")

            telescope.setup(opts)

            telescope.load_extension("fzf")
            -- telescope.load_extension("dap")
            telescope.load_extension("notify")
            telescope.load_extension("media_files")
        end
    },

    -- {
    --     "nvim-telescope/telescope-dap.nvim",
    --     dependencies = { "nvim-telescope/telescope.nvim" }
    -- },

    {
        "nvim-telescope/telescope-media-files.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" }
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        dependencies = { "nvim-telescope/telescope.nvim" }
    },

    {
        "nvim-telescope/telescope-fzf-writer.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" }
    }
}
