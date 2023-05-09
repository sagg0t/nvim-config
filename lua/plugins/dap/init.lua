return {
    {
        "mfussenegger/nvim-dap",
        keys = {
            {
                "<Leader>db",
                function() require('dap').toggle_breakpoint() end,
                silent = true,
                noremap = true,
                desc = "Insert a debug breakpoint"
            },
            {
                "<Leader>dc",
                function() require('dap').continue() end,
                silent = true,
                noremap = true,
                desc = "Start/resume a debug session"
            },
            {
                "<Leader>dr",
                function() require('dap').repl.open() end,
                silent = true,
                noremap = true,
                desc = "Open a debug REPL"
            },
        },
        config = function()
        end
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap"
        }
    },

    {
        "leoluz/nvim-dap-go",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            require("dap-go").setup()
        end
    }
}
