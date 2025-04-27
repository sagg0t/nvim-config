local set = vim.opt_local

set.shiftwidth = 2
set.tabstop = 2
set.softtabstop = 2

local ruby_lsp_attach_group = vim.api.nvim_create_augroup("sagg0t Ruby LspAttach", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = ruby_lsp_attach_group,
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if (not client) or (client.name ~= "ruby_lsp") then return end

        local registered_commands = vim.api.nvim_get_commands({ builtin = false })
        if not registered_commands["Gems"] then
            vim.api.nvim_create_user_command(
                "Gems",
                function()
                    local params = vim.lsp.util.make_text_document_params()

                    client.request("rubyLsp/workspace/dependencies", params, function(error, gems)
                        if error then
                            print("Error showing deps: " .. error)
                            return
                        end

                        -- item format {
                        --   dependency = false, -- direct or indirect dependency
                        --   name = "rake",
                        --   path = "<path to gem>
                        --   version = "13.2.1"
                        -- }

                        vim.ui.select(
                            gems,
                            {
                                prompt = "Select a gem:",
                                format_item = function(item)
                                    return string.format("%s (%s)", item.name, item.version)
                                end
                            },
                            function(selection)
                                if not selection then return end

                                vim.cmd(string.format("split %s", selection.path))
                            end
                        )
                    end)
                end,
                {}
            )
        end
    end
})
