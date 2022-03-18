local telescope = require("telescope")
local actions = require("telescope.actions")
local sorters = require("telescope.sorters")

telescope.setup({
    defaults = {
        mappings = {
            -- i = {
            --     ["<ESC>"] = actions.close,
            -- }
        },
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    },
    pickers = {
        live_grep = { prompt_title = "Search" },
        find_files = {
            layout_strategy = "center",
            sorting_strategy = "ascending",
            prompt_title = "Search",
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
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true
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
vim.api.nvim_set_keymap("n", "<Leader>ff", "<CMD>Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>ft", "<CMD>Telescope live_grep<CR>", opts)

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
