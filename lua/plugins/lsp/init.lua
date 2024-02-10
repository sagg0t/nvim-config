local lsp_config = require("plugins.lsp.config")

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "onsails/lspkind-nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim"
        },
        opts = lsp_config,
        config = function(_, opts)
            -- vim.lsp.set_log_level("trace")


            -- To instead override globally
            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, preview_opts, ...)
                preview_opts = preview_opts or {}
                preview_opts.border = preview_opts.border or opts.icons.border
                return orig_util_open_floating_preview(contents, syntax, preview_opts, ...)
            end


            vim.diagnostic.config(opts.diagnostics)


            for type, icon in pairs(opts.icons.diagnostics) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end


            local servers = require("plugins.lsp.server")

            local function setup(server)
                local server_opts = servers[server] or {}
                server_opts.capabilities = opts.capabilities()
                server_opts.on_attach = opts.on_attach
                -- if opts.setup[server] then
                --     if opts.setup[server](server, server_opts) then
                --         return
                --     end
                -- elseif opts.setup["*"] then
                --     if opts.setup["*"](server, server_opts) then
                --         return
                --     end
                -- end
                require("lspconfig")[server].setup(server_opts)
            end

            local mlsp = require("mason-lspconfig")
            local available = mlsp.get_available_servers()

            local ensure_installed = {} ---@type string[]
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or not vim.tbl_contains(available, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
            require("mason-lspconfig").setup_handlers({ setup })
        end
    },

    require("plugins.lsp.mason"),
    "williamboman/mason-lspconfig.nvim",

    require("plugins.lsp.null_ls"),

    {
        "onsails/lspkind-nvim",
        name = "lspkind"
    },

    {
        "p00f/clangd_extensions.nvim",
        name = "clangd_extensions",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        opts = {
            server = {
                on_attach = lsp_config.on_attach,
                capabilities = lsp_config.capabilities()
            }
        }
    },
}
