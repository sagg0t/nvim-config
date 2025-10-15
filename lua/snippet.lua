local M = {
    store = {}
}

setmetatable(M.store, {
    __index = function (t, k)
        local v = rawget(t, k)
        if not v then
            t[k] = {}
        end

        return rawget(t, k)
    end
})

--- Add snippets for filetype.
---@param ft string
---@param snippets table[]
function M.add(ft, snippets)
    for _, snip in ipairs(snippets) do
        table.insert(M.store[ft], snip)
    end
end

local function get_ft(buf)
    local has_parser, parser = pcall(vim.treesitter.get_parser, buf, nil)
    if not has_parser or parser == nil then
        return vim.bo[buf].filetype
    end

    -- Compute local (at cursor) TS language
    local pos = vim.api.nvim_win_get_cursor(0)
    local lang_tree = parser:language_for_range({ pos[1] - 1, pos[2], pos[1] - 1, pos[2] })

    return lang_tree:lang() or vim.bo[buf].filetype
end

--- @return boolean
function M.expand()
    local buf = vim.api.nvim_get_current_buf()
    local ft = get_ft(buf)

    local snippets = M.store[ft]
    if #snippets == 0 then return false end

    local lnum, col = vim.fn.line("."), vim.fn.col(".")
    local to = col - (vim.fn.mode() == 'i' and 1 or 0)
    local line = vim.fn.getline(lnum):sub(1, to)

    local best_id, best_match_width = nil, 0
    local pattern_boundary = '^[%s%p]?$'
    for i, s in ipairs(snippets) do
        local w = (s.prefix or ''):len()
        if best_match_width < w and line:sub(-w) == s.prefix and
            line:sub(-w - 1, -w - 1):find(pattern_boundary) then
          best_id, best_match_width = i, w
        end
    end

    if best_id == nil then return false end

    local snip = snippets[best_id]
    local region = {
        from = { line = lnum, col = to - best_match_width + 1 },
        to = { line = lnum, col = to },
    }

    if snip.body == nil then
        vim.notify("missing snippet body", vim.log.levels.ERROR)
        return false
    end

    vim.api.nvim_buf_set_text(0, region.from.line - 1, region.from.col - 1, region.to.line - 1, region.to.col, {})
    vim.api.nvim_win_set_cursor(0, { region.from.line, region.from.col - 1 })

    local body = snip.body
    if type(body) == "table" then
        body = table.concat(body, "\n")
    end

    vim.snippet.expand(body)

    return true
end

return M
