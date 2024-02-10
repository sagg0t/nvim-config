return {
    {
        "folke/tokyonight.nvim",
        dependencies = { "lukas-reineke/indent-blankline.nvim" },
        lazy = false,
        config = function()
            vim.g.tokyonight_style = "night"
            vim.g.tokyonight_dark_sidebar = true
            vim.g.tokyonight_dark_float = true

            -- vim.cmd("colorscheme tokyonight")
        end
    }
}
