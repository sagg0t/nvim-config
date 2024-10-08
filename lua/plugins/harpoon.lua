return {
    {
        "ThePrimeagen/harpoon",
        lazy = true,
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            {
                "<Leader>a",
                function()
                    require("harpoon"):list():add()
                end,
                desc = "Harpoon add"
            },
            {
                "<Leader>H",
                function()
                    local harpoon = require("harpoon")
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Harpoon list"
            },
            { "<Leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon 1-st item" },
            { "<Leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2-nd item" },
            { "<Leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3-rd item" },
            { "<Leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4-th item" },
            { "<Leader>5", function() require("harpoon"):list():select(5) end, desc = "Harpoon 5-th item" },
        }
    }
}
