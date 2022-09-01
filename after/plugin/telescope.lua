local telescope = require("telescope")

telescope.setup({
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
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }
        }
    }
})

telescope.load_extension("fzf")
telescope.load_extension("dap")
telescope.load_extension("ui-select")
telescope.load_extension("notify")
telescope.load_extension("media_files")



local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Leader>ff", "<CMD>Telescope find_files<CR>", opts)
vim.keymap.set("n", "<Leader>ft", "<CMD>Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<Leader>fs", "<CMD>Telescope lsp_document_symbols<CR>", opts)
vim.keymap.set("n", '<Leader>fo', '<CMD>Telescope oldfiles<CR>', opts) -- { desc = 'recently opened files' } }
vim.keymap.set("n", '<Leader>fh', '<CMD>Telescope help_tags<CR>', opts) -- { desc = 'vim help' } }
vim.keymap.set("n", '<Leader>fk', '<CMD>Telescope keymaps<CR>', opts)
vim.keymap.set("n", '<Leader>fO', '<CMD>Telescope vim_options<CR>', opts)
vim.keymap.set("n", '<Leader>f/', '<CMD>Telescope current_buffer_fuzzy_find<CR>', opts) -- search in file
vim.keymap.set("n", '<Leader>f?', '<CMD>Telescope search_history<CR>', opts) -- 'search history'
vim.keymap.set("n", '<Leader>f;', '<CMD>Telescope command_history<CR>', opts) -- , { desc = 'command-line history' } }
vim.keymap.set("n", '<Leader>fc', '<CMD>Telescope commands<CR>', opts) -- , { desc = 'execute command' } }

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
