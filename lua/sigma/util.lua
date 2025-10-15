local hsluv = require("sigma.hsluv")

local hex = "[abcdef0-9][abcdef0-9]"
local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
-- Should match theme to properly blend
local bgColor = "#161616"
local fgColor = "#F6FADE"

local util = {}

---@param hex_str string hex color string
function util.hexToRgb(hex_str)
    hex_str = string.lower(hex_str)

    assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

    local r, g, b = string.match(hex_str, pat)
    return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

---@param a number color channel value
---@param b number color channel value
local blendChannel = function(a, b, alpha)
    local ret = (alpha * a + ((1 - alpha) * b))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
end

---@param a string foreground color
---@param b string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
function util.blend(a, b, alpha)
    a = util.hexToRgb(a)
    b = util.hexToRgb(b)

    return string.format("#%02X%02X%02X",
        blendChannel(a[1], b[1], alpha),
        blendChannel(a[2], b[2], alpha),
        blendChannel(a[3], b[3], alpha))
end

---@param hexCol string
---@param amount number
function util.darken(hexCol, amount)
    return util.blend(hexCol, bgColor, math.abs(amount))
end

---@param hexCol string
---@param amount number
function util.lighten(hexCol, amount)
    return util.blend(hexCol, fgColor, math.abs(amount))
end

function util.brighten(color, percentage)
    local hsl = hsluv.hex_to_hsluv(color)
    local larpSpace = 100 - hsl[3]
    if percentage < 0 then
        larpSpace = hsl[3]
    end
    hsl[3] = hsl[3] + larpSpace * percentage
    return hsluv.hsluv_to_hex(hsl)
end

return util
