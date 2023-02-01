return {
    {
        "sindrets/diffview.nvim",
        opts = { use_icons = false }
    },

    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signcolumn = false,
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 200,
                virt_text_pos = 'eol'
            }
        }
    }
}
