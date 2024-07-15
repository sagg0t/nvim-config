return {
    {
        "nvim-neotest/neotest",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "olimorris/neotest-rspec",
            "nvim-neotest/neotest-go"
        },
        keys = {
            {
                "<Leader>tn",
                function() require("neotest").run.run() end,
                silent = false,
                desc = "nearest"
            },
            {
                "<Leader>tf",
                function() require("neotest").run.run(vim.fn.expand("%")) end,
                silent = false,
                desc = "file"
            },
            {
                "<Leader>ta",
                function() require("neotest").run.attach() end,
                silent = false,
                desc = "all"
            },
            {
                "<Leader>ts",
                function() require("neotest").summary.toggle() end,
                silent = false,
                desc = "summary"
            },
            {
                "<Leader>to",
                function() require("neotest").output_panel.toggle() end,
                silent = false,
                desc = "output pannel"
            }
        },
        cmd = "Neotest",
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-rspec"),
                    require("neotest-go")
                },
                output = {
                    open_on_run = true
                },
                discovery = {
                    enabled = false
                },
                icons = {
                    failed = "",
                    notify = "",
                    passed = "",
                    running = "",
                    skipped = "",
                    unknown = "",
                    watching = "",
                    running_animated = { "⠙", "⠸", "⢰", "⣠", "⣄", "⡆", "⠇", "⠋" },
                },
            })
        end
    }
}
