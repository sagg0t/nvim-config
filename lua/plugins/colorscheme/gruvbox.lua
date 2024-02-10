return {
    {
        "sainnhe/gruvbox-material",
        config = function()
            vim.g.gruvbox_material_background = "medium"
            -- vim.g.gruvbox_material_transparent_background = 2
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_enable_bold = 1
            vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
            vim.cmd.colorscheme("gruvbox-material")
        end
    }
}
