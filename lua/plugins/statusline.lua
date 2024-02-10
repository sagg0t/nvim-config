return {
    {
        "hoob3rt/lualine.nvim",
        opts = {
            options = {
                theme = "sigma",
                component_separators = { left = '', right = ''},
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = {},
                lualine_b = {
                    {
                        "filename",
                        file_status = true,
                        path = 0
                    },
                },
                lualine_c = { "diagnostics" },

                lualine_x = {},
                lualine_y = { 'filetype' },
                lualine_z = {
                    {
                        'progress',
                        padding = { left = 0, right = 1 }
                    },
                    {
                        'location',
                        padding = 1
                    }
                }
            }
        }
    }
}
