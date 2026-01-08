local ns = vim.api.nvim_create_namespace("sagg0t.ui.dap")
--- @class DAPScopes
--- @field buf number
--- @field win number
local DAPScopes = {}
DAPScopes.__index = DAPScopes

SCOPES = nil

function DAPScopes:toggle()
    if self.win then
        self:close()
    else
        self:open()
    end
end

local function value_hl(v)
    if v == "true" or v == "false" then
        return "@boolean"
    elseif v:match("^\".+\"$") then
        return "@string"
    elseif v:match("^%d[%d%.e]+$") then
        return "@number"
    else
        return "@variable"
    end
end

local function hl(buf, line, start_col, end_col, group)
    vim.api.nvim_buf_set_extmark(buf, ns, line, start_col, {
        end_col = end_col, hl_group = group
    })
end

local function bprint(buf, variables, indent, lineNr)
    if not variables then return lineNr end

    local sep = ": "

    for _, var in ipairs(variables) do
        vim.api.nvim_buf_set_lines(buf, lineNr, -1, false, {
            string.rep("\t", indent) .. var.name .. " " .. var.type .. sep .. var.value,
        })

        local name_start = indent
        local name_end = name_start + #var.name
        hl(buf, lineNr, name_start, name_end, "@variable")

        local type_start = name_end + 1
        local type_end = type_start + #var.type
        hl(buf, lineNr, type_start, type_end, "@type")

        local sep_start = type_end
        local sep_end = sep_start + 1
        hl(buf, lineNr, sep_start, sep_end, "@operator")

        local val_start = sep_end + 1
        hl(buf, lineNr, val_start, nil, value_hl(var.value))

        lineNr = bprint(buf, var.variables, indent + 1, lineNr + 1)
    end

    return lineNr
end

function DAPScopes:open()
    if self.win then return end

    local session = require("dap").session()
    if not session then
        vim.notify("No DAP session is running")
        return
    end

    local scopes = session.current_frame.scopes
    SCOPES = scopes

    if not self.buf then
        self.buf = vim.api.nvim_create_buf(false, true)
    end

    if not self.win then
        local win_w = math.floor(vim.o.columns * 0.7)
        local win_h = math.floor(vim.o.lines * 0.7)
        self.win = vim.api.nvim_open_win(self.buf, true, {
            relative = "editor",
            width = win_w,
            height = win_h,
            row = math.floor((vim.o.lines - win_h) / 2),
            col = math.floor((vim.o.columns - win_w) / 2),
            footer = "DAP Scopes",
            style = "minimal",
            border = "rounded",
        })
    end

    self:draw(scopes)
end

function DAPScopes:close()
    if not self.win then
        vim.notify("No DAP scopes is open")
        return
    end

    vim.api.nvim_win_hide(self.win)
    self.win = nil
end

function DAPScopes:draw(scopes)
    local ln = 0
    for _, scope in ipairs(scopes) do
        vim.api.nvim_buf_set_lines(self.buf, ln, -1, false, { scope.name })
        hl(self.buf, ln, 0, #scope.name, "DapUIScope")

        ln = ln + 1
        ln = bprint(self.buf, scope.variables, 1, ln)
    end
end

return setmetatable({}, DAPScopes)

