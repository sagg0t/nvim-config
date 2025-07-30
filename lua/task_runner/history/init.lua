local api = vim.api

--- @class HistoryEntry
--- @field ID number
--- @field cmd string
--- @field buf number buf ID
--- @field code number? exit code


--- @class History
--- @field capacity number
--- @field entries HistoryEntry[]
local History = {}
History.__index = History


--- @param capacity number
---
--- @return History
function History.new(capacity)
    local self = setmetatable({}, History)

    self.capacity = capacity
    self.entries = {}

    return self
end

--- @param entry HistoryEntry
function History:push(entry)
    if #self.entries >= self.capacity then
        local oldest = self.entries[#self.entries]
        api.nvim_buf_delete(oldest.buf, {force = true})

        table.remove(self.entries)
    end

    table.insert(self.entries, 1, entry)
end

function History:update_entry_code(id, code)
    for _, t in ipairs(self.entries) do
        if t.ID == id then
            t.code = code
        end
    end
end

return History
