return {
    {
        "tpope/vim-dadbod",
        enabled = false,
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
        enabled = false,
        dependencies = {
            "tpope/vim-dadbod",
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
}
