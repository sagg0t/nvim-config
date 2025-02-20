local function fzf() return require("fzf-lua") end

return {
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "FzfLua",
        keys = {
            { "<Leader>ff", function() fzf().files() end,           desc = "files" },
            { "<Leader>ft", function() fzf().grep_project() end,    desc = "text" },
            { "<Leader>fb", function() fzf().buffers() end,         desc = "buffers" },
            { "<Leader>fh", function() fzf().helptags() end,        desc = "help tags" },
            { "<Leader>fH", function() fzf().highlights() end,      desc = "highlight groups" },
            { "<Leader>fk", function() fzf().keymaps() end,         desc = "keymaps" },
            { "<Leader>fO", function() fzf().nvim_options() end,    desc = "vim options" },
            { "<Leader>f/", function() fzf().lines() end,           desc = "buf fuzzy find" },
            { "<Leader>f?", function() fzf().search_history() end,  desc = "search history" },
            { "<Leader>f;", function() fzf().command_history() end, desc = "command history" },
            { "<Leader>fc", function() fzf().commands() end,        desc = "commands" },
        },
        opts = {
            { "ivy" }, -- base profile
            formatter = "path.dirname_first",
            winopts = {
                preview = {
                    scrollchars = { "┃", "" },
                    border = function(_, m)
                        if m.type == "fzf" then
                            return "single"
                        else
                            assert(m.type == "nvim" and m.name == "prev" and type(m.layout) == "string")
                            local b = { "┌", "─", "┐", "", "┘", "─", "└", "" }
                            if m.layout == "down" then
                                b[1] = "├" --top right
                                b[3] = "┤" -- top left
                            elseif m.layout == "up" then
                                b[7] = "├" -- bottom left
                                b[6] = "" -- remove bottom
                                b[5] = "┤" -- bottom right
                            elseif m.layout == "left" then
                                b[3] = "┬" -- top right
                                b[5] = "┴" -- bottom right
                                b[6] = "" -- remove bottom
                            else -- right
                                b[1] = "┬" -- top left
                                b[7] = "┴" -- bottom left
                                b[6] = "" -- remove bottom
                            end
                            return b
                        end
                    end,
                }
            },
            files = {
                cwd_prompt = false,
            },
            grep = {
                cwd_prompt = false,
            },
            keymap = {
                builtin = {
                    true,
                    ["<C-d>"] = "preview-page-down",
                    ["<C-u>"] = "preview-page-up",
                },
                fzf = {
                    true,
                    ["ctrl-d"] = "preview-page-down",
                    ["ctrl-u"] = "preview-page-up",
                    ["ctrl-q"] = "select-all+accept",
                },
            },
        }
    }
}
