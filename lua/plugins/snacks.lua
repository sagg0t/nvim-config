return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        keys = {
            { "<Leader>ff", function() Snacks.picker.files() end,           desc = "Find files" },
            { "<Leader>ft", function() Snacks.picker.grep() end,            desc = "Grep" },
            { "<Leader>fb", function() Snacks.picker.buffers() end,         desc = "buffers" },
            { "<Leader>fh", function() Snacks.picker.help() end,            desc = "help tags" },
            {
                "<Leader>fH",
                function() Snacks.picker.highlights({ layout = "ivy" }) end,
                desc = "highlight groups",
            },
            { "<Leader>fk", function() Snacks.picker.keymaps() end,         desc = "keymaps" },
            { "<Leader>f/", function() Snacks.picker.lines() end,           desc = "buf fuzzy find" },
            { "<Leader>f?", function() Snacks.picker.search_history() end,  desc = "search history" },
            { "<Leader>f;", function() Snacks.picker.command_history() end, desc = "command history" },
            { "<Leader>fc", function() Snacks.picker.commands() end,        desc = "commands" },
        },
        opts = {
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
        }
    }
}
