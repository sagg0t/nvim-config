return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        enabled = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            {
                "s1n7ax/nvim-window-picker",
                version = "2.*",
                name = "window-picker",
                opts = {
                    hint = "floating-big-letter",
                    show_prompt = false,
                    filter_rules = {
                        autoselect_one = true,
                        include_current = false,
                        bo = {
                            -- if the file type is one of following, the window will be ignored
                            filetype = { "neo-tree", "neo-tree-popup", "notify", "noice" },
                            -- if the buffer type is one of following, the window will be ignored
                            buftype = { "terminal", "quickfix", "nofile" },
                        },
                    },
                    other_win_hl_color = '#e35e4f',
                },
            },
        },

        keys = {
            { "<C-b>", "<CMD>Neotree filesystem toggle<CR>", silent = true }
        },

        init = function()
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
        end,

        opts = {
            sources = {
                "filesystem",
                "buffers",
                "git_status",
                "document_symbols",
            },
            close_if_last_window = true,
            enable_git_status = false,
            use_popups_for_input = false, -- If false, inputs will use vim.ui.input() instead of custom floats.

            source_selector = {
                winbar = true,
            },

            window = {
                -- use_libuv_file_watcher = true
                mappings = {
                    -- ["o"] = "open_with_window_picker",
                    ["o"] = "open",
                    ["i"] = "open_split",
                    ["s"] = "open_vsplit",
                    ["w"] = "none"
                }
            },

            filesystem = {
                window = {
                    position = "float",
                }
            },

            document_symbols = {
                follow_cursor = true,
                window = {
                    position = "right",
                    width = 30
                },
                kinds = {
                    Unknown = { icon = "?", hl = "" },
                    Root = { icon = "", hl = "NeoTreeRootName" },
                    File = { icon = "", hl = "Tag" },
                    Module = { icon = "", hl = "Exception" },
                    Namespace = { icon = "", hl = "Include" },
                    Package = { icon = "", hl = "Label" },
                    Class = { icon = "", hl = "Include" },
                    Method = { icon = "", hl = "Function" },
                    Property = { icon = "", hl = "@property" },
                    Field = { icon = "", hl = "@field" },
                    Constructor = { icon = "", hl = "@constructor" },
                    Enum = { icon = "了", hl = "@number" },
                    Interface = { icon = "", hl = "Type" },
                    Function = { icon = "", hl = "Function" },
                    Variable = { icon = "", hl = "@variable" },
                    Constant = { icon = "", hl = "Constant" },
                    String = { icon = "", hl = "String" },
                    Number = { icon = "", hl = "Number" },
                    Boolean = { icon = "", hl = "Boolean" },
                    Array = { icon = "", hl = "Type" },
                    Object = { icon = "", hl = "Type" },
                    Key = { icon = "", hl = "" },
                    Null = { icon = "", hl = "Constant" },
                    EnumMember = { icon = "", hl = "Number" },
                    Struct = { icon = "", hl = "Type" },
                    Event = { icon = "", hl = "Constant" },
                    Operator = { icon = "", hl = "Operator" },
                    TypeParameter = { icon = "", hl = "Type" },
                }
            }
        },
    }
}
