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
    }
}
