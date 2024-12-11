require("plugins.lsp.code_actions")

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("sagg0t LspAttach", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then return end

        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
        end

        map("gd", vim.lsp.buf.definition, "Goto Definition")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("gO", require("telescope.builtin").lsp_document_symbols, "Document Symbols")

        if client.supports_method("textDocumet/formatting", 0) then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
                end
            })
        end
    end
})

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", cmd = "Mason" },
            "saghen/blink.cmp",
            "onsails/lspkind-nvim",
            {
                "j-hui/fidget.nvim",
                opts = {}
            },
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {},
            },
        },
        config = function()
            -- vim.lsp.set_log_level("trace")

            local servers = require("plugins.lsp.servers")
            local caps = vim.lsp.protocol.make_client_capabilities()
            caps = require("blink.cmp").get_lsp_capabilities(caps)

            require("mason").setup()

            for server, options in pairs(servers) do
                options.capabilities = vim.tbl_deep_extend(
                    "force",
                    {},
                    caps,
                    server.capabilities or {}
                )

                require("lspconfig")[server].setup(options)
            end

            vim.lsp.inlay_hint.enable(true)
        end
    },

    require("plugins.lsp.null_ls"),

    {
        "p00f/clangd_extensions.nvim",
        ft = { "c", "cpp", "swift", "rust" },
        name = "clangd_extensions",
        dependencies = { "saghen/blink.cmp" },
        opts = {
            server = {
                capabilities = require("blink.cmp").get_lsp_capabilities(
                    vim.lsp.protocol.make_client_capabilities()
                )
            }
        }
    },
}
