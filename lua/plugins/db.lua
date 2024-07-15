return {
    {
        "tpope/vim-dadbod",
        lazy = true,
        cmd = {
            "DB",
            "DBUI",
            "DBUIClose",
            "DBUIToggle",
            "DBUIFindBuffer",
            "DBUIRenameBuffer",
            "DBUIAddConnection",
            "DBUILastQueryInfo",
            "DapToggleBreakpoint",
        }
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            "tpope/vim-dadbod",
            "kristijanhusak/vim-dadbod-completion",
        },
        lazy = true,
        cmd = {
            "DB",
            "DBUI",
            "DBUIClose",
            "DBUIToggle",
            "DBUIFindBuffer",
            "DBUIRenameBuffer",
            "DBUIAddConnection",
            "DBUILastQueryInfo",
            "DapToggleBreakpoint",
        },
    },

    {
        "kndndrj/nvim-dbee",
        enabled = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        build = function()
            -- Install tries to automatically detect the install method.
            -- if it fails, try calling it with one of these parameters:
            --    "curl", "wget", "bitsadmin", "go"
            require("dbee").install()
        end,
        config = function()
            require("dbee").setup( --[[optional config]])
        end,
    },
}
