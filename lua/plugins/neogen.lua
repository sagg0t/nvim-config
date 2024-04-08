return {
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true,
        keys = {
            { "<Leader>nf", function() require("neogen").generate() end }
        }
    }
}
