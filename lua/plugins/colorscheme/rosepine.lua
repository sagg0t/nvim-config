return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        -- enabled = false,
        config = function()
            require("rose-pine").setup({
                disable_background = true,
                disable_float_background = true,
            })

            vim.cmd.colorscheme("rose-pine")
            vim.cmd("hi DiagnosticUnderlineInfo gui=NONE cterm=NONE")
        end
    }
}
