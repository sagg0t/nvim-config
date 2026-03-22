vim.cmd.packadd("cfilter")

vim.keymap.set("n", "<C-/>", function()
    local winid = vim.api.nvim_get_current_win()
    local info = vim.fn.getwininfo(winid)[1]

    local cmd
    if info.loclist == 1 then
        cmd = "Lfilter"
    else
        cmd = "Cfilter"
    end

    vim.ui.input({ prompt = "Filter: " }, function(input)
        if not input or input == "" then
            return
        end

        vim.cmd(cmd .. " " .. input)
    end)
end, { buf = 0 })
