-- local diagnostics_icons = { Error = "󰃤", Warn = "", Info = "󰍩", Hint = "" }
local diagnostics_icons = { Error = "󰅚", Warn = "󰀪", Info = "󰋽", Hint = "󰌶" }
for type, icon in pairs(diagnostics_icons) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
        format = function(d)
            return d.message
        end
    },
    virtual_text = {
        source = "if_many",
        format = function(d)
            --     local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
            --     if d.lnum == lnum then return nil end
            --
            return d.message
        end
    },
    float = { source = true },
    underline = true,
})
