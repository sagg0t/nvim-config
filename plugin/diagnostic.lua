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
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN] = "󰀪",
            [vim.diagnostic.severity.INFO] = "󰋽",
            [vim.diagnostic.severity.HINT] = "󰌶"
        }
    }
})
-- text = {
--     [vim.diagnostic.severity.ERROR] = "󰅚",
--     [vim.diagnostic.severity.WARN] = "󰀪",
--     [vim.diagnostic.severity.INFO] = "󰋽",
--     [vim.diagnostic.severity.HINT] = "󰌶"
-- }
-- text = {
--     [vim.diagnostic.severity.ERROR] = "󰃤",
--     [vim.diagnostic.severity.WARN] = "",
--     [vim.diagnostic.severity.INFO] = "󰍩",
--     [vim.diagnostic.severity.HINT] = ""
-- }
