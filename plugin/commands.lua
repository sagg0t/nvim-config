vim.api.nvim_create_user_command(
    "LspLog",
    function(opts)
        local logfile = vim.lsp.log.get_filename()

        if opts.args == "clear" then
            local success, error = os.remove(logfile)

            if success then
                vim.notify("LspLog: LSP log file deleted")
            else
                vim.notify(error, vim.log.levels.ERROR)
            end
        elseif opts.args == "" then
            vim.cmd("tabnew " .. logfile)
        else
            vim.notify("LspLog: unknow arg - " .. opts.args)
        end
    end,
    {
        nargs = "?",
        desc = "Opens LSP logfile in a new tab",
        complete = function() return { "clear" } end,
    }
)
