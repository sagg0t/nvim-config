return {
    {
        "olehvolynets/sigma.nvim",
        branch = "v0.2",
        name = "sigma",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("sigma")
        end
    }
}
