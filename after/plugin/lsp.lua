local lsp = require("lspconfig")
-- local configs = require("lspconfig.configs")
local fidget = require("fidget")
local navic = require("nvim-navic")
require('mason').setup()
require('mason-lspconfig').setup()

vim.lsp.set_log_level("trace")
---@diagnostic disable-next-line: unused-vararg
local on_attach = function(client, bufnr, ...)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    navic.attach(client, bufnr)

    -- Mappings
    local opts = { buffer = bufnr }
    vim.keymap.set('n', '<space>lD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<space>ld', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<space>lh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<space>li', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>ls', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>le', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<space>la', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>q', '<cmd>TroubleToggle workspace_diagnostics<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        vim.keymap.set('n', '<space>lf', vim.lsp.buf.formatting, opts)
    elseif client.resolved_capabilities.document_range_formatting then
        vim.keymap.set('v', '<space>lf', vim.lsp.buf.formatting, opts)
    end
end

vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#fff]]

-- configs.ruby_lsp = {
--     default_config = {
--          cmd = {"bundle", "exec", "ruby-lsp"},
--          filetypes = { "ruby" },
--          root_dir = function(fname)
--            return lsp.util.find_git_ancestor(fname)
--          end,
--          -- settings = {}
--     }
-- }

local border = {
    -- { "┏", "FloatBorder" },
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    -- { "┓", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    -- { "┛", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    -- { "┗", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
}
-- local border = "single"

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.diagnostic.config({
    virtual_text = { source = "always" },
    float = { source = "always" },
})

local signs = { Error = "", Warn = "", Hint = "", Info = "" }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

local language_servers = {
    "solargraph",
    -- "ruby_lsp",
    "sorbet",
    "sumneko_lua",
    "clangd",
    "jsonls",
    "gopls"
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local concrete_configs = {
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = runtime_path,
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    },
    gopls = {
        cmd = { "gopls", "serve" },
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true
            }
        }
    },
    -- solargraph = {
    --     cmd = { "solargraph", "stdio" }
    -- },
    -- sorbet = {
    --     cmd = { 'bundle', 'exec', 'srb', 'tc', '--lsp', '--disable-watchman' }
    -- }
}

local default_config = { on_attach = on_attach, capabilities = capabilities }

for _, server in pairs(language_servers) do
    local config = vim.tbl_extend("error", default_config, concrete_configs[server] or {})

    lsp[server].setup(config)
end

fidget.setup({})
