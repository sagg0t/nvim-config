local function once(cb)
    local done = false

    return function(...)
        if done then return end

        done = true

        cb(...)
    end
end

local function command(name, cb)
    vim.api.nvim_create_user_command(name, function()
        vim.api.nvim_del_user_command(name)

        cb()

        vim.api.nvim_command(name)
    end, {})
end

local lazy_load_g = vim.api.nvim_create_augroup("sagg0t.VimEnter", { clear = true })
local function on_ui_enter(cb)
    vim.api.nvim_create_autocmd("VimEnter", {
        group = lazy_load_g,
        callback = function()
            cb()
        end,
        once = true
    })
end

return {
    once = once,
    command = command,
    on_ui_enter = on_ui_enter,
}
