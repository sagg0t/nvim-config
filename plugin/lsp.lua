local code_action = require("override.code_action")
vim.lsp.buf.code_action = code_action

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
        map("gO", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
        map("<leader>lf", vim.lsp.buf.format, "Format document")

        if client.supports_method("textDocument/formatting", 0) then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = pre_write_group,
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
                end
            })
        end
    end
})
