return {
    {
        "nvim-neotest/neotest",
        lazy = true,
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "olimorris/neotest-rspec",
            "fredrikaverpil/neotest-golang"
        },
        keys = {
            {
                "<Leader>tn",
                function() require("neotest").run.run() end,
                silent = false,
                desc = "nearest"
            },
            {
                "<Leader>tN",
                function() require("neotest").run.run({ suite = false, strategy = "dap" }) end,
                silent = false,
                desc = "nearest [DAP]"
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
        opts = {
            adapters = {
                function(...) return require("neotest-rspec")(...) end,
                function(...) return require("neotest-golang")(...) end,
            },
            output = { open_on_run = true },
            discovery = { enabled = false },
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
        }
    }
}
