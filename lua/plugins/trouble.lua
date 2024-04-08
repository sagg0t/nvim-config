return {
    {
        "folke/trouble.nvim",
        branch = "dev",
        keys = {
            {
                "<space>q",
                function()
                    require("trouble").toggle({
                        mode = "diagnostics",
                        filter = { buf = 0 }
                    })
                end,
                desc = "Current buf diagnostics"
            },
            {
                "<space>Q",
                function()
                    require("trouble").toggle("diagnostics")
                end,
                desc = "Workspace diagnostics"
            }
        },
        opts = {
            signs = {
                error = "󰃤",
                warning = "",
                hint = "",
                information = "󰍩",
            }
        }
    }
}
