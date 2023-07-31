return {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      --Please make sure you install markdown and markdown_inline parser
      "nvim-treesitter/nvim-treesitter"
    },
    opts = {
        lightbulb = { enable = false },
        outline = {
            win_position = "left"
        },
        -- ui = {
        --     title = false,
        -- },
    },
}
