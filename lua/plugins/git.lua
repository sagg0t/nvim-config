return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = "VeryLazy",
        cmd = "Gitsigns",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            vim.keymap.set("n", "<leader>gb", function() require("gitsigns").blame_line({ full = true }) end),
            vim.keymap.set("n", "<leader>gh", function() require("gitsigns").stage_hunk() end),
            vim.keymap.set("n", "<leader>gH", function() require("gitsigns").undo_stage_hunk() end),
            vim.keymap.set("n", "<leader>gd", function() require("gitsigns").diffthis() end),
            vim.keymap.set("n", "<leader>gst", function() require("gitsigns").toggle_signs() end),
        },
        opts = {
            signcolumn = true,
            current_line_blame = true,
            current_line_blame_opts = { delay = 1000, virt_text_pos = "eol" },
            current_line_blame_formatter = "<author>, <author_time:%R>",
        }
    }
}
