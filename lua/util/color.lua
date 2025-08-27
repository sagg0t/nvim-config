local M = {}

local colors = {
    black = 30,
    red = 31,
    green = 32,
    yellow = 33,
    blue = 34,
    purple = 35,
    cyan = 36,
    white = 37,
}


--- @class Opts
---
--- @field bg boolean
--- @field bright boolean
---
--- @field bold boolean
--- @field thin boolean
--- @field italic boolean
--- @field underline boolean
--- @field strike boolean

local function paint(s, color_code, opts)
    if opts.bg then
        color_code = color_code + 10
    end

    if opts.bright then
        color_code = color_code + 60
    end

    local modifier = 0 -- normal
    if opts.bold then
        modifier = 1
    elseif opts.thin then
        modifier = 2
    elseif opts.italic then
        modifier = 3
    elseif opts.underline then
        modifier = 4
    elseif opts.strike then
        modifier = 9
    end

    local fmt = string.format("\x1b[%d;%dm%%s\x1b[0m", modifier, color_code)

    return string.format(fmt, s)
end

--- @param s string
--- @param opts Opts?
--- @return string
function M.black(s, opts)   return paint(tostring(s), colors.black, opts or {}) end
function M.red(s, opts)     return paint(tostring(s), colors.red, opts or {}) end
function M.green(s, opts)   return paint(tostring(s), colors.green, opts or {}) end
function M.yellow(s, opts)  return paint(tostring(s), colors.yellow, opts or {}) end
function M.blue(s, opts)    return paint(tostring(s), colors.blue, opts or {}) end
function M.purple(s, opts)  return paint(tostring(s), colors.purple, opts or {}) end
function M.cyan(s, opts)    return paint(tostring(s), colors.cyan, opts or {}) end
function M.white(s, opts)   return paint(tostring(s), colors.white, opts or {}) end


return M
