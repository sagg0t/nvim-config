local M = {}
local fnamemodify = vim.fn.fnamemodify

local stl_bg = vim.api.nvim_get_hl(0, { name = 'StatusLine' }).bg or 'black'
local function stl_attr(group)
    local color = vim.api.nvim_get_hl(0, { name = group, link = false })
    return {
        bg = stl_bg,
        fg = color.fg,
    }
end

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
        name = 'filetype',
        stl = function()
            local alias = {
                cpp = 'C++',
                javascript = "JavaScript"
            }

            local ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
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
            end

            return icon .. " " .. pretty_ft
        end,
        event = { 'BufEnter' },
    }
end

function M.progress()
    local spinner = { '⣶', '⣧', '⣏', '⡟', '⠿', '⢻', '⣹', '⣼' }
    local idx = 1
    return {
        stl = function(args)
            if args.data and args.data.params then
                local val = args.data.params.value
                if val.message and val.kind ~= 'end' then
                    idx = idx + 1 > #spinner and 1 or idx + 1
                    return ('%s'):format(spinner[idx - 1 > 0 and idx - 1 or 1])
                end
            end
            return ''
        end,
        name = 'LspProgress',
        event = { 'LspProgress' },
        attr = stl_attr('Type'),
    }
end

function M.lsp()
    return {
        stl = function(args)
            local client = vim.lsp.get_clients({ bufnr = 0 })[1]
            if not client then
                return ''
            end
            local msg = ''
            if args.data and args.data.params then
                local val = args.data.params.value
                if not val.message or val.kind == 'end' then
                    msg = ('[%s:%s]'):format(
                        client.name,
                        client.root_dir and fnamemodify(client.root_dir, ':t') or 'single'
                    )
                else
                    msg = ('%s %s%s'):format(
                        val.title,
                        (val.message and val.message .. ' ' or ''),
                        (val.percentage and val.percentage .. '%' or '')
                    )
                end
            elseif args.event == 'BufEnter' or args.event == 'LspAttach' then
                msg = ('[%s:%s]'):format(
                    client.name,
                    client.root_dir and fnamemodify(client.root_dir, ':t') or 'single'
                )
            elseif args.event == 'LspDetach' then
                msg = ''
            end
            return '   %-20s' .. msg
        end,
        name = 'Lsp',
        event = { 'LspProgress', 'LspAttach', 'LspDetach', 'BufEnter' },
    }
end

local function diagnostic_info()
    local diagnostics_icons = { "󰅚 ", "󰀪 ", "󰋽 ", "󰌶 " }

    return function()
        if not vim.diagnostic.is_enabled({ bufnr = 0 }) or #vim.lsp.get_clients({ bufnr = 0 }) == 0 then
            return ''
        end
        local t = {}
        for i = 1, 4 do
            local count = #vim.diagnostic.get(0, { severity = i })
            if count > 0 then
                t[#t + 1] = ('%%#StatusLine%s#%s%s%%*'):format(vim.diagnostic.severity[i], diagnostics_icons[i], count)
            end
        end
        return table.concat(t, ' ')
    end
end

function M.diagnostic()
    for i = 1, 4 do
        local name = ('Diagnostic%s'):format(vim.diagnostic.severity[i])
        local fg = vim.api.nvim_get_hl(0, { name = name }).fg
        vim.api.nvim_set_hl(0, 'StatusLine' .. vim.diagnostic.severity[i], { fg = fg, bg = stl_bg })
    end
    return {
        stl = diagnostic_info(),
        event = { 'DiagnosticChanged', 'BufEnter', 'LspAttach' },
    }
end

function M.encoding()
    return {
        stl = ('%s'):format(vim.bo.fileencoding),
        name = 'filencode',
        event = { 'BufEnter' },
    }
end

return M
