local ok, plenary_reload = pcall(require, "plenary.reload")
local reloader
if not ok then
    reloader = require
else
    reloader = plenary_reload.reload_module
end

P = function(v)
    print(vim.inspect(v))
    return v
end

RELOAD = function(...)
    return reloader(...)
end

R = function(name)
    plenary_reload(name)
    return require(name)
end

return {}
