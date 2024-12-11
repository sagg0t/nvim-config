-- use "~/dev/cs/roshnivim-cs"
-- use "ellisonleao/gruvbox.nvim"
-- use "RRethy/nvim-base16"
-- use "rebelot/kanagawa.nvim"
-- use "sainnhe/sonokai"
-- use "martinsione/darkplus.nvim"
-- use "B4mbus/oxocarbon-lua.nvim"

return {
    {
        "olehvolynets/sigma.nvim",
        dir = "~/devel/sigma.nvim",
        name = "sigma",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("sigma")
            vim.cmd("hi Normal guibg=NONE")
            vim.cmd("hi Visual guibg=#424556")
            vim.cmd("hi VisualNOS guibg=#424556")
            vim.cmd("hi link @lsp.typemod.variable.default_library @variable.builtin")
            vim.cmd("hi IndentLine guifg=#373C45")
            vim.cmd("hi IndentLineCurrent guifg=#dc3c70")
        end
    },

    -- {
    --     "folke/tokyonight.nvim",
    --     enabled = false,
    --     dependencies = { "lukas-reineke/indent-blankline.nvim" },
    --     lazy = false,
    --     config = function()
    --         vim.g.tokyonight_style = "night"
    --         vim.g.tokyonight_dark_sidebar = true
    --         vim.g.tokyonight_dark_float = true
    --
    --         -- vim.cmd("colorscheme tokyonight")
    --     end
    -- },

    -- {
    --     "catppuccin/nvim",
    --     enabled = false,
    --     name = "catppuccin",
    --     lazy = false,
    --     priority = 1000,
    -- },

    -- {
    --     "Mofiqul/vscode.nvim",
    --     enabled = false,
    --     opts = {
    --         transparent = false,
    --         italic_comments = true,
    --         disable_nvimtree_bg = true
    --     },
    -- },

    -- {
    --     "rose-pine/neovim",
    --     enabled = false,
    --     name = "rose-pine",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("rose-pine").setup({
    --             disable_background = true,
    --             disable_float_background = true,
    --         })
    --
    --         vim.cmd.colorscheme("rose-pine")
    --         vim.cmd("hi DiagnosticUnderlineInfo gui=NONE cterm=NONE")
    --     end
    -- },

    -- {
    --     "sainnhe/gruvbox-material",
    --     enabled = false,
    --     config = function()
    --         vim.g.gruvbox_material_background = "medium"
    --         -- vim.g.gruvbox_material_transparent_background = 2
    --         vim.g.gruvbox_material_enable_italic = 1
    --         vim.g.gruvbox_material_enable_bold = 1
    --         vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
    --         vim.cmd.colorscheme("gruvbox-material")
    --     end
    -- }
}
