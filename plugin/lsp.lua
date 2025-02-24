local code_action_override = require("override.code_action")
-- local diagnostic_override = require("override.diagnostic")

vim.lsp.buf.code_action = code_action_override
-- vim.diagnostic.handlers.virtual_text = diagnostic_override.handlers.virtual_text

local caps = vim.lsp.protocol.make_client_capabilities()
caps = require("blink.cmp").get_lsp_capabilities(caps)

vim.lsp.config("*", {
    capabilities = caps
})

vim.lsp.enable({
    "bashls",
    -- "clangd",
    "cssls",
    "dockerls",
    "eslint",
    "gopls",
    "htmx",
    "jsonls",
    "lua_ls",
    "neocmake",
    "ruby_lsp",
    -- "rust_analyzer",
    "tailwindcss",
    "terraformls",
    "ts_ls",
    "zls",
})

-- vim.lsp.set_log_level("trace")
vim.lsp.inlay_hint.enable(true)

local pre_write_group = vim.api.nvim_create_augroup("sagg0t BufWritePre", { clear = true })
local lsp_attach_group = vim.api.nvim_create_augroup("sagg0t LspAttach", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_attach_group,
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then return end

        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
        end

        map("gd", vim.lsp.buf.definition, "Goto Definition")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("gO", function() require("fzf-lua").lsp_document_symbols() end, "Document Symbols")
        map("<leader>lf", vim.lsp.buf.format, "Format document")

        if client:supports_method("textDocument/formatting", 0) then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = pre_write_group,
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
                end
            })
        end

        if client:supports_method("textDocument/foldingRange", 0) then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldmethod = "expr"
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end

        if client.name == "ruby_lsp" then
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
    end
})
