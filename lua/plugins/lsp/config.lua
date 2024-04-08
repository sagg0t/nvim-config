return {
    diagnostics = {
        virtual_text = { source = "always" },
        float = { source = "always" },
        underline = true,
    },
    icons = {
        diagnostics = { Error = "󰃤", Warn = "", Hint = "", Info = "󰍩" },
        border = {
            { "╭", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╮", "FloatBorder" },
            { "│", "FloatBorder" },
            { "╯", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╰", "FloatBorder" },
            { "│", "FloatBorder" },
        }
    },
    on_attach = function(_client, bufnr, ...)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "<space>lD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "<space>ld", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<space>li", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<space>lR",
            function()
                require("trouble").toggle({ mode = "lsp_references", focus = true })
            end,
            opts
        )
        vim.keymap.set("n", "<space>lh", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<space>ls", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>lr", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<space>le", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<space>la", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<space>lS", require("telescope.builtin").lsp_document_symbols)
        vim.keymap.set("n", "<space>lf", vim.lsp.buf.format, opts)
    end,
    capabilities = function()
        local caps = require("cmp_nvim_lsp").default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )
        caps.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }

        return caps
    end
}
