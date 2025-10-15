local util = require("util.load")

vim.pack.add({
    "https://github.com/szw/vim-maximizer",
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/Wansmer/treesj",
    "https://github.com/danymat/neogen",

    "https://github.com/nvim-tree/nvim-web-devicons",

    "https://github.com/folke/todo-comments.nvim",

    {
        src = "https://github.com/ThePrimeagen/harpoon",
        version = "harpoon2"
    }
})

util.on_ui_enter(function()
    require("nvim-web-devicons").setup({ default = true })
    require("nvim-surround").setup({})
    require("nvim-autopairs").setup({})
    require("treesj").setup({
        use_default_keymaps = false,
        max_join_length = 1000
    })

    require("todo-comments").setup({
        signs = false,
        highlight = {
            multiline = false,
            keyword = "fg",
            after = "",                                  -- "fg" or "bg" or empty
            pattern = [[.*<(KEYWORDS)(\(\.\*\))?\s*\W]], -- pattern or table of patterns, used for highlighting (vim regex)
        },
        search = {
            pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--glob=!node_modules",
                "--glob=!vendor/bundle",
                "--glob=!.git",
            },
        }
    })

    require("neogen").setup({})
end)

vim.keymap.set("n", "<Leader>m",
    ":MaximizerToggle<CR>",
    { noremap = true, silent = true, desc = "Maximizer"})

vim.keymap.set( "n", "<Leader>fn",
    function() Snacks.picker.todo_comments() end,
    { noremap = true, silent = true, desc = "Workspace TODO comments" })

vim.keymap.set("n", "gs", function() require("treesj").toggle() end)
vim.keymap.set("n", "gS", function()
    require("treesj").toggle({ split = { recursive = true } })
end)

vim.keymap.set("n", "<Leader>nf", function() require("neogen").generate() end)

-- {
--     "nvimdev/indentmini.nvim",
--     enabled = false,
--     event = "VeryLazy",
--     opts = {}
-- },
