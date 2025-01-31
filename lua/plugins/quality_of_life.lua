return {
    {
        "kylechui/nvim-surround",
        opts = {}
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },

    {
        "Wansmer/treesj",
        lazy = true,
        keys = {
            { "gs", function() require("treesj").toggle() end },
            { "gS", function() require("treesj").toggle({ split = { recursive = true } }) end },
        },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            use_default_keymaps = false,
            max_join_length = 1000
        }
    },

    {
        "ThePrimeagen/git-worktree.nvim",
        lazy = true
    },
}
