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
            { "gj", function() require("treesj").join() end },
            { "gs", function() require("treesj").split() end },
            { "gS", function() require("treesj").split({ split = { recursive = true } }) end },
        },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            use_default_keymaps = false,
            max_join_length = 200
        }
    },

    {
        "ThePrimeagen/git-worktree.nvim",
    },
}
