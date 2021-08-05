-------------------------------------------------------
--
--------------------  TELESCOPE  ----------------------
-------------------------------------------------------

local telescope = require('telescope')
local actions = require('telescope.actions')
local sorters = require('telescope.sorters')

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-j>'] = actions.move_selection_next,
                ['<ESC>'] = actions.close,
            }
        },
    },
    pickers = {
        live_grep = {
            prompt_title = 'Search',
            layout_config = {
                preview_width = function(_, max_columns, _)
                    return math.min(max_columns - 3, 70)
                end,
            },
        },
        find_files = {
            layout_strategy = 'center',
            sorting_strategy = 'ascending',
            prompt_title = 'Search',
            show_preview = false,
            preview = false,
            layout_config = {
                width = function(_, max_columns, _)
                    return math.min(max_columns - 3, 80)
                end,
                height = function(_, _, max_lines)
                    return math.min(max_lines - 4, 25)
                end,
                preview_cutoff = 100 -- have no idea how it works, any value above 40 removes preview
            },
        },
    },
    extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = false, -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
        }
    }
})

telescope.load_extension('fzf')
telescope.load_extension('dap')

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<C-p>', '<CMD>Telescope find_files<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<C-o>', '<CMD>Telescope live_grep<CR>', opts)

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

-- vim.api.nvim_exec(
--     [[
--         highlight TelescopeSelection      guifg=#569cd6 gui=bold
--         highlight TelescopeSelectionCaret guifg=#f44747
--         highlight TelescopeMultiSelection guifg=#928374
--         highlight TelescopeNormal         guibg=#1e1e1e
-- 
--         highlight TelescopeBorder         guifg=#505050 gui=bold
--         highlight TelescopePromptBorder   guifg=#505050 gui=bold
--         highlight TelescopeResultsBorder  guifg=#505050 gui=bold
--         highlight TelescopePreviewBorder  guifg=#505050 gui=bold
-- 
--         highlight TelescopeMatching       guifg=#608b4e
--         highlight TelescopePromptPrefix   guifg=#f44747
--     ]],
--     true
-- )
