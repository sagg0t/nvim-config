vim.pack.add({
    "https://github.com/nvim-neotest/neotest",
    "https://github.com/fredrikaverpil/neotest-golang",
})

local util = require("util.load")

local setup = util.once(function()
    require("neotest").setup({
        adapters = {
        --     -- function(...) return require("neotest-rspec")(...) end,
            require("neotest-golang")({
                experimental = {
                    test_table = true,
                },
            }),
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
        -- log_level = vim.log.levels.TRACE
    })
end)

vim.keymap.set("n", "<Leader>tn",
    function()
        setup()
        require("neotest").run.run()
    end,
    { silent = false, desc = "nearest" })

vim.keymap.set("n", "<Leader>tN",
    function()
        setup()
        require("neotest").run.run({ suite = false, strategy = "dap" })
    end,
    { silent = false, desc = "nearest [DAP]" })

vim.keymap.set("n", "<Leader>tf",
    function()
        setup()
        require("neotest").run.run(vim.fn.expand("%"))
    end,
    { silent = false, desc = "file" })

vim.keymap.set("n", "<Leader>ta",
    function()
        setup()
        require("neotest").run.attach()
    end,
    { silent = false, desc = "all" })

vim.keymap.set("n", "<Leader>ts",
    function()
        setup()
        require("neotest").summary.toggle()
    end,
    { silent = false, desc = "summary" })

vim.keymap.set("n", "<Leader>to",
    function()
        setup()
        require("neotest").output_panel.toggle()
    end,
    { silent = false, desc = "output pannel" })
