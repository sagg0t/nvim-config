--- @class FnWrapper
--- @field fn function
--- @field title string
---
--- @operator call(): nil
local FnWrapper = {}
FnWrapper.__index = FnWrapper

--- @return FnWrapper
function FnWrapper.new(fn)
    local self = setmetatable({}, FnWrapper)

    self.fn = fn
    self.title = "fn"

    return self
end

function FnWrapper:__call()
    self.fn()
end


return FnWrapper
