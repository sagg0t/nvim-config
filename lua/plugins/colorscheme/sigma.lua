return {
    {
        "olehvolynets/sigma.nvim",
        branch = "v0.2",
        dir = "~/devel/sigma.nvim.git/v0.2",
        name = "sigma",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("hi Normal guibg=NONE")
            vim.cmd.colorscheme("sigma")
        end
    }
}
