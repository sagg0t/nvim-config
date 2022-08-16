-- local neogit = require('neogit')
local diffview = require('diffview')
local gitsigns = require('gitsigns')


---------------------------------
------------ NEOGIT -------------
---------------------------------
-- neogit.setup({
--     integrations = {
--         diffview = true,
--     }
-- })

-- vim.api.nvim_exec(
--     [[
--         hi NeogitDiffAddHighlight guibg=#008080
--         hi NeogitDiffDeleteHighlight guibg=#f44747
--         hi NeogitDiffContextHighlight guibg=#333333 guifg=#b2b2b2
--         hi NeogitHunkHeader guifg=#cccccc guibg=#404040
--         hi NeogitHunkHeaderHighlight guifg=#cccccc guibg=#4d4d4d
--     ]],
--     true
-- )

-- vim.keymap.set('n', '<Leader>gg', '<CMD>Neogit<CR>', { noremap = true, silent = true })


---------------------------------
----------- DIFFVIEW ------------
---------------------------------

diffview.setup({
    use_icons = false
})


---------------------------------
----------- GITSIGNS ------------
---------------------------------
gitsigns.setup({
    signcolumn = false,
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 200,
        virt_text_pos = 'eol'
    }
})
