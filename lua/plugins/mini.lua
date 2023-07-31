return {
    {
        "echasnovski/mini.nvim",
        version = false,
        lazy = false,
        opts = {
            move = {
                mappings = {
                  -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                  left = "<",
                  right = ">",
                  down = "<C-j>",
                  up = "<C-k>",

                  -- Move current line in Normal mode
                  line_left = "<",
                  line_right = ">",
                  line_down = "<C-j>",
                  line_up = "<C-k>",
                },
            },
            cursorword = {
                delay = 69,
            },
        },
        config = function(_, opts)
            require("mini.move").setup(opts.move)
            require("mini.cursorword").setup(opts.cursorword)
        end
    }
}
