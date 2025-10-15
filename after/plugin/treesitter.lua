vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
    },
}, { load = true })

local cmd_group = vim.api.nvim_create_augroup("sagg0t.treesitter", { clear = true })
local ts = require("nvim-treesitter")

-- Lua is built in.
-- Doesn't work for: markdown, embeded template, gotmpl
vim.api.nvim_create_autocmd("FileType", {
    group = cmd_group,
    pattern = ts.get_available(),
    callback = function(evt)
        local ok, _ = pcall(vim.treesitter.start, evt.buf)
        if not ok then
            vim.notify("TS parser for " .. evt.match .. " is missing, installing...", vim.log.levels.INFO)
            ts.install(evt.match):wait(120000)
            pcall(vim.treesitter.start, evt.buf)
        end
    end
})

vim.api.nvim_create_autocmd({ "PackChanged" }, {
    group = cmd_group,
    callback = function(evt)
        if evt.spec.name == "nvim-treesitter" and
            (evt.kind == "install" or evt.kind == "update") then
            vim.cmd("TSUpdate")
        end
    end
})
