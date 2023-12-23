local fmtGroup = vim.api.nvim_create_augroup("LspFormatting", {})

return {
    "jose-elias-alvarez/null-ls.nvim",
    -- dir = "~/devel/null-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.code_actions.gomodifytags,
                null_ls.builtins.code_actions.impl,

                null_ls.builtins.diagnostics.buf,

                null_ls.builtins.formatting.gofumpt,
                null_ls.builtins.formatting.goimports_reviser,
            },
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = fmtGroup, buffer = bufnr })

                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = fmtGroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end
                    })
                end
            end
        })
    end
}
