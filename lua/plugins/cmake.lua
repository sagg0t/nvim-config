return {
    {
        "Shatur/neovim-tasks",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {},
        config = function(_, opts)
            local path = require('plenary.path')

            require('tasks').setup({
                default_params = {
                    cmake = {
                        build_dir = tostring(path:new('{cwd}', 'build')), --'{os}-{build_type}')),
                        args = {
                            configure = {}
                        },
                    }
                },
            })
        end,
    }
}
