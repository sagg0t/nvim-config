local sources = require("ui.statusline_sources")

local function stl_format(name, val)
    return ('%%#StatusLine%s#%s%%*'):format(name, val)
end

local events, pieces = {}, {}
local components = {
    "  ",
    sources.fileinfo(),
    " ",
    sources.diagnostic(),
    '%=',
    -- sources.progress(),
    sources.filetype(),
    sources.encoding(),
    ' %P %l:%c  ',
}

vim.iter(ipairs(components)):map(function(key, item)
    if type(item) == 'string' then
        pieces[#pieces + 1] = item
    elseif type(item.stl) == 'string' then
        pieces[#pieces + 1] = stl_format(item.name, item.stl)
    else
        pieces[#pieces + 1] = item.default and stl_format(item.name, item.default) or ''
        for _, event in ipairs({ unpack(item.event or {}) }) do
            events[event] = events[event] or {}
            events[event][#events[event] + 1] = key
        end
    end
    if item.attr and item.name then
        vim.api.nvim_set_hl(0, ('StatusLine%s'):format(item.name), item.attr)
    end
end):totable()

local stl_render = coroutine.create(function(args)
    while true do
        local event = args.event == 'User' and ('%s %s'):format(args.event, args.match) or args.event
        for _, idx in ipairs(events[event]) do
            if components[idx].async then
                local child = components[idx].stl()
                coroutine.resume(child, pieces, idx)
            else
                pieces[idx] = stl_format(components[idx].name, components[idx].stl(args))
            end
        end
        vim.opt.stl = table.concat(pieces)
        args = coroutine.yield()
    end
end)

vim.iter(vim.tbl_keys(events)):map(function(e)
    local tmp = e
    local pattern
    if e:find('User') then
        pattern = vim.split(e, '%s')[2]
        tmp = 'User'
    end
    vim.api.nvim_create_autocmd(tmp, {
        pattern = pattern,
        callback = function(args)
            vim.schedule(function()
                local ok, res = coroutine.resume(stl_render, args)
                if not ok then
                    vim.notify('[StatusLine] render failed ' .. res, vim.log.levels.ERROR)
                end
            end)
        end,
        desc = '[StatusLine] update',
    })
end)
