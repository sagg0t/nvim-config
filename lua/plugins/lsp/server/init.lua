return vim.tbl_extend(
    'error',
    require('plugins.lsp.server.sumneko'),
    require('plugins.lsp.server.solargraph'),
    require('plugins.lsp.server.jsonls'),
    require('plugins.lsp.server.gopls'),
    require('plugins.lsp.server.sorbet'),
    require('plugins.lsp.server.ruby_lsp'),
    require('plugins.lsp.server.tsserver')
)
