vim.keymap.set("n", "<Leader>a",
    function() require("harpoon"):list():add() end,
    { desc = "Harpoon add" })
vim.keymap.set("n", "<Leader>H",
    function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    { desc = "Harpoon list" })
vim.keymap.set("n", "<Leader>1",
    function() require("harpoon"):list():select(1) end,
    { desc = "Harpoon 1-st item" })
vim.keymap.set("n", "<Leader>2",
    function() require("harpoon"):list():select(2) end,
    { desc = "Harpoon 2-nd item" })
vim.keymap.set("n", "<Leader>3",
    function() require("harpoon"):list():select(3) end,
    { desc = "Harpoon 3-rd item" })
vim.keymap.set("n", "<Leader>4",
    function() require("harpoon"):list():select(4) end,
    { desc = "Harpoon 4-th item" })
vim.keymap.set("n", "<Leader>5",
    function() require("harpoon"):list():select(5) end,
    { desc = "Harpoon 5-th item" })
