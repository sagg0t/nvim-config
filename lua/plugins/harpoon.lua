return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<Leader>a", function() require("harpoon"):list():append() end },
            {
                "<Leader>H",
                function()
                    local harpoon = require("harpoon")
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end
            },
            { "<Leader>1", function() require("harpoon"):list():select(1) end },
            { "<Leader>2", function() require("harpoon"):list():select(2) end },
            { "<Leader>3", function() require("harpoon"):list():select(3) end },
            { "<Leader>4", function() require("harpoon"):list():select(4) end },
            { "<Leader>5", function() require("harpoon"):list():select(5) end },
        }
    }
}
