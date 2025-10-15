vim.pack.add({ "https://github.com/williamboman/mason.nvim" })

local util = require("util.load")

util.command("Mason", function()
    require("mason").setup({})
end)
