vim.pack.add({
    "https://github.com/nvim-neotest/neotest",
    "https://github.com/fredrikaverpil/neotest-golang",
}, { load = true })

local util = require("util.load")

local setup = util.once(function()
    require("neotest").setup({
        adapters = {
        --     -- function(...) return require("neotest-rspec")(...) end,
            require("neotest-golang")({
                runner = "gotestsum",
                experimental = {
                    test_table = true,
                },
            }),
        },
        output = { open_on_run = true },
        discovery = { enabled = false },
        status = {
            signs = false,
            virtual_text = true
        },
        quickfix = {
          enabled = true,
          open = false
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
        strategies = {
            dap = {
                switchbuf = "useopen",
                before = function()
                    -- require("dapui").open({})
                end,
            },
        },
        log_level = vim.log.levels.TRACE,
    })
end)

vim.keymap.set("n", "<Leader>tn",
    function()
        setup()
        require("neotest").run.run()
    end,
    { silent = false, desc = "Test nearest" })

vim.keymap.set("n", "<Leader>tN",
    function()
        setup()
        require("neotest").run.run({ suite = false, strategy = "dap" })
    end,
    { silent = false, desc = "Test nearest [DAP]" })

vim.keymap.set("n", "<Leader>tf",
    function()
        setup()
        require("neotest").run.run(vim.fn.expand("%"))
    end,
    { silent = false, desc = "Test file" })

vim.keymap.set("n", "<Leader>tF",
    function()
        setup()
        require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
    end,
    { silent = false, desc = "Test file [DAP]" })


vim.keymap.set("n", "<Leader>tl",
    function()
        setup()
        require("neotest").run.run_last()
    end,
    { silent = false, desc = "Re-run last test" })

vim.keymap.set("n", "<Leader>tL",
    function()
        setup()
        require("neotest").run.run_last({ strategy = "dap" })
    end,
    { silent = false, desc = "Re-run last test [DAP]" })

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

vim.keymap.set("n", "<Leader>tK",
    function()
        setup()
        require("neotest").output.open({ short = true })
    end,
    { silent = false, desc = "output pannel" })
