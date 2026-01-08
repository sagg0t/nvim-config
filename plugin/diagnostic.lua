local signs = {
    [vim.diagnostic.severity.ERROR] = "󰅚",
    [vim.diagnostic.severity.WARN] = "󰀪",
    [vim.diagnostic.severity.INFO] = "󰋽",
    [vim.diagnostic.severity.HINT] = "󰌶"
}
local hl_map = {
  [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
  [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
  [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
  [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
}

vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
        format = function(d)
            return d.message
        end
    },
    virtual_text = {
        current_line = false,
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
    signs = false,
    status = {
        format = function(counts)
            local items = {}
            for level, _ in ipairs(vim.diagnostic.severity) do
                local count = counts[level]
                if count then
                    local hl = hl_map[level]
                    table.insert(items, ("%%#%s#%s %s"):format(hl, signs[level], count))
                end
            end

            return table.concat(items, " ")
        end
    },
    -- signs = {
    --     text = {
    --         [vim.diagnostic.severity.ERROR] = "󰅚",
    --         [vim.diagnostic.severity.WARN] = "󰀪",
    --         [vim.diagnostic.severity.INFO] = "󰋽",
    --         [vim.diagnostic.severity.HINT] = "󰌶"
    --     }
    -- }
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
