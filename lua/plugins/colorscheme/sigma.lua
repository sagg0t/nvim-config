return {
    {
        "olehvolynets/sigma.nvim",
        -- dir = "~/devel/sigma.nvim",
        lazy = false,
        priority = 1000,
        enabled = false,
        init = function()
            vim.g.sigma_style = "night"
            vim.g.sigma_dark_sidebar = true
            vim.g.sigma_dark_float = true
        end,
        config = function()
            vim.cmd.colorscheme("sigma")
        end
    }
}
