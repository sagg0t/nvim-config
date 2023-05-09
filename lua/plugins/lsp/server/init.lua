return vim.tbl_extend(
    'error',
    require('plugins.lsp.server.lua_ls'),
    require('plugins.lsp.server.solargraph'),
    require('plugins.lsp.server.jsonls'),
    require('plugins.lsp.server.gopls'),
    require('plugins.lsp.server.sorbet'),
    require('plugins.lsp.server.ruby_lsp'),
    require('plugins.lsp.server.neocmake'),
    -- require('plugins.lsp.server.tsserver'),
    require('plugins.lsp.server.eslint'),
    require('plugins.lsp.server.sql')
)
