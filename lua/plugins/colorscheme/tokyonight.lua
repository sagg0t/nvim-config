return {
    {
        "folke/tokyonight.nvim",
        dependencies = { "lukas-reineke/indent-blankline.nvim" },
        enabled = false,
        config = function()
            vim.cmd("colorscheme tokyonight")
        end
    }
}
