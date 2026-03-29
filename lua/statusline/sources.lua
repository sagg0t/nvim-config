local M = {}
local fnamemodify = vim.fn.fnamemodify

local stl_bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg or "#000000"

function M.fileinfo()
    return {
        stl = function()
            local s = { "%t" }

            if vim.bo.modified then
                s[#s + 1] = "%m"
            end

            if vim.bo.readonly then
                s[#s + 1] = "%r"
            end

            return table.concat(s, " ")
        end,
        name = "fileinfo",
        event = { "BufEnter", "BufModifiedSet", "FileChangedRO" },
        attr = {
            bold = true,
            bg = stl_bg,
        },
    }
end

function M.filetype()
    return {
        name = "filetype",
        stl = function()
            local alias = {
                cpp = "C++",
                javascript = "JavaScript",
                dapui_breakpoints = "DAP UI breakpoints",
                dapui_scopes = "DAP UI scopes",
                dapui_watches = "DAP UI watches",
                ["dap-repl"] = "DAP REPL",
            }

            local ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
            local capital = ft:sub(1, 1):upper()
            local pretty_ft = alias[ft] and alias[ft] or capital .. ft:sub(2, #ft)
            local icon, icon_hl_group = require("nvim-web-devicons").get_icon(vim.fn.expand("%:t", ft))

            if icon ~= nil and icon_hl_group ~= nil then
                local hl_name = "StatusLineFT" .. icon_hl_group
                local existing_hl = vim.api.nvim_get_hl(0, { name = hl_name })

                if vim.tbl_isempty(existing_hl) then
                    local icon_hl = vim.api.nvim_get_hl(0, { name = icon_hl_group })
                    local stl_icon_hl = {
                        fg = icon_hl.fg,
                        bg = stl_bg,
                        ctermfg = icon_hl.ctermfg,
                    }

                    vim.api.nvim_set_hl(0, hl_name, stl_icon_hl)
                end

                icon = ("%%#%s#%s%%*"):format(hl_name, icon)
            elseif icon == nil then
                return ""
            end

            return icon .. " " .. pretty_ft
        end,
        event = { "BufEnter" },
    }
end

-- local spinner = { "⣶", "⣧", "⣏", "⡟", "⠿", "⢻", "⣹", "⣼" }

function M.lsp()
    return {
        stl = function(args)
            local client = vim.lsp.get_clients({ bufnr = 0 })[1]
            if not client then
                return ""
            end
            local msg = ""
            if args.data and args.data.params then
                local val = args.data.params.value
                if not val.message or val.kind == "end" then
                    msg = ("[%s:%s]"):format(
                        client.name,
                        client.root_dir and fnamemodify(client.root_dir, ":t") or "single"
                    )
                else
                    msg = ("%s %s%s"):format(
                        val.title,
                        (val.message and val.message .. " " or ""),
                        (val.percentage and val.percentage .. "%" or "")
                    )
                end
            elseif args.event == "BufEnter" or args.event == "LspAttach" then
                msg = ("[%s:%s]"):format(
                    client.name,
                    client.root_dir and fnamemodify(client.root_dir, ":t") or "single"
                )
            elseif args.event == "LspDetach" then
                msg = ""
            end
            return "   %-20s" .. msg
        end,
        name = "Lsp",
        event = { "LspProgress", "LspAttach", "LspDetach", "BufEnter" },
    }
end

function M.diagnostic()
    return {
        stl = function()
            return vim.diagnostic.status()
        end,
        event = { "DiagnosticChanged", "BufEnter", "LspAttach" },
    }
end

function M.encoding()
    return {
        stl = ("%s"):format(vim.bo.fileencoding),
        name = "filencode",
        event = { "BufEnter" },
    }
end

return M
