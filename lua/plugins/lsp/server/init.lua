return vim.tbl_extend(
    "error",
    -- require("plugins.lsp.server.ts"),
    require("plugins.lsp.server.js"),
    require("plugins.lsp.server.go"),
    require("plugins.lsp.server.json"),
    require("plugins.lsp.server.lua"),
    require("plugins.lsp.server.cmake"),
    require("plugins.lsp.server.ruby"),
    require("plugins.lsp.server.rust"),
    require("plugins.lsp.server.sql"),
    require("plugins.lsp.server.swift")
)
