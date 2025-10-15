vim.pack.add({ "https://github.com/folke/snacks.nvim" })

local util = require("util.load")

util.on_ui_enter(function()
    require("snacks").setup({
        picker = {
            enabled = true,
            prompt = " ",
            -- from telescope config selection_caret = " ",
            matcher = {
                frecency = true,
            },
            layout = {
                preset = "ivy_split",
            }
        },
    })
end)

vim.keymap.set("n", "<Leader>ff",
    function()
        Snacks.picker.files({
            hidden = true,
            ignored = true,
            exclude = {".git/", "node_modules/", "tmp/", ".DS_Store"},
        })
    end,
    { desc = "Find files", }
)
vim.keymap.set("n", "<Leader>ft", function() Snacks.picker.grep() end,            { desc = "Grep" })
vim.keymap.set("n", "<Leader>fb", function() Snacks.picker.buffers() end,         { desc = "buffers" })
vim.keymap.set("n", "<Leader>fh", function() Snacks.picker.help() end,            { desc = "help tags" })
vim.keymap.set("n", "<Leader>fH",
    function() Snacks.picker.highlights({ layout = "ivy" }) end,
    { desc = "highlight groups" }
)
vim.keymap.set("n", "<Leader>fk", function() Snacks.picker.keymaps() end,         { desc = "keymaps" })
