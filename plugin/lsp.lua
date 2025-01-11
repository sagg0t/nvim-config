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
