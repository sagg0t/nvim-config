local util = require("util.load")

vim.pack.add({
    "https://github.com/szw/vim-maximizer",
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/Wansmer/treesj",

    "https://github.com/nvim-tree/nvim-web-devicons",

    "https://github.com/folke/todo-comments.nvim",

    {
        src = "https://github.com/ThePrimeagen/harpoon",
        version = "harpoon2"
    }
}, { load = true })

util.on_ui_enter(function()
    require("nvim-web-devicons").setup({ default = true })
    require("nvim-surround").setup({})
    require("treesj").setup({
        use_default_keymaps = false,
        max_join_length = 1000
    })

    local signs = {
        [vim.diagnostic.severity.ERROR] = "󰅚",
        [vim.diagnostic.severity.WARN] = "󰀪",
        [vim.diagnostic.severity.INFO] = "󰋽",
        [vim.diagnostic.severity.HINT] = "󰌶",
    }


    -- == SHOULD WORK ==
    -- FIX: ddddddasdasdasdasdasda
    -- ddddd
    -- FIX: ddd
    -- TODO: What else?
    -- NOTE: adding a note
    --
    -- FIX: this needs fixing
    -- WARN: ???
    -- WARNING: ???
    -- FIX: ddddd
    --       continuation
    -- @TODO foobar

    -- == SHOULD NOT WORK ==
    -- TODO alskdjf
    -- @hack foobar

    require("todo-comments").setup({
        signs = false,
        highlight = {
            multiline = false,
            keyword = "fg",
            after = "", -- "fg" or "bg" or empty
            -- pattern = [[.*<(KEYWORDS)(\(\.\*\))?\s*\W*]], -- pattern or table of patterns, used for highlighting (vim regex)
            pattern = [[<(KEYWORDS)(\(\.\*\))?\s*\W*]], -- pattern or table of patterns, used for highlighting (vim regex)
        },
        gui_style = { fg = "BOLD", },
        colors = {
        },
        keywords = {
            FIX = {
                icon = signs[vim.diagnostic.severity.ERROR],
                color = "error",
                alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
            },
            WARN = {
                icon = signs[vim.diagnostic.severity.WARN],
                color = "warning",
                alt = { "WRN", "WARNING" },
            },
            NOTE = {
                icon = signs[vim.diagnostic.severity.INFO],
                color = "hint",
                alt = { "INFO" },
            },
            TODO = { icon = " ", color = "info", },
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
end)

vim.keymap.set("n", "<Leader>m",
    ":MaximizerToggle<CR>",
    { noremap = true, silent = true, desc = "Maximizer" })

vim.keymap.set("n", "gs", function() require("treesj").toggle() end)
vim.keymap.set("n", "gS", function()
    require("treesj").toggle({ split = { recursive = true } })
end)

-- {
--     "nvimdev/indentmini.nvim",
--     enabled = false,
--     event = "VeryLazy",
--     opts = {}
-- },
