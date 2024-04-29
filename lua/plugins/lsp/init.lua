vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("sagg0t LspAttach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
        end

        map("<space>ld", vim.lsp.buf.definition, "Goto Definition")
        map("<space>lD", vim.lsp.buf.declaration, "Goto Declaration")
        map("<space>li", vim.lsp.buf.implementation, "Goto Implementation")
        map("<space>lR", vim.lsp.buf.references, "References")
        map("<space>lh", vim.lsp.buf.hover, "Hover")
        map("<space>ls", vim.lsp.buf.signature_help, "Signature")
        map("<space>lr", vim.lsp.buf.rename, "Rename")
        map("<space>le", vim.diagnostic.open_float, "Float diagnostics")
        map("<space>la", vim.lsp.buf.code_action, "Code Actions")
        map("<space>lS", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
        map("<space>lf", vim.lsp.buf.format, "Format")
    end
})

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
            { "williamboman/mason.nvim", cmd = "Mason" },
            "williamboman/mason-lspconfig.nvim",
            "onsails/lspkind-nvim",
            {
                "j-hui/fidget.nvim",
                opts = {}
            },
            { "folke/neodev.nvim", opts = {} },
        },
        config = function()
            -- vim.lsp.set_log_level("trace")

            local servers = require("plugins.lsp.servers")
            local ensure_installed = vim.tbl_keys(servers)
            local caps = require("cmp_nvim_lsp").default_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            )
            -- caps.textDocument.foldingRange = {
            --     dynamicRegistration = false,
            --     lineFoldingOnly = true
            -- }

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = ensure_installed,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, caps, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end
                },
            })
        end
    },

    require("plugins.lsp.null_ls"),

    {
        "p00f/clangd_extensions.nvim",
        name = "clangd_extensions",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        opts = {
            server = {
                capabilities = require("cmp_nvim_lsp").default_capabilities(
                    vim.lsp.protocol.make_client_capabilities()
                )
            }
        }
    },
}
