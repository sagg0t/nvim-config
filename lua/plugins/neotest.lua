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
            { "<Leader>tn", function() require("neotest").run.run() end, silent = false },
            { "<Leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, silent = false },
            { "<Leader>ta", function() require("neotest").run.attach() end, silent = false },
            { "<Leader>ts", function() require("neotest").summary.toggle() end, silent = false },
            { "<Leader>to", function() require("neotest").output_panel.toggle() end, silent = false }
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
