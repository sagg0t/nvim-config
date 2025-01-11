---@type table<string, vim.lsp.Config>
return {
    cmd = { "gopls" },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_markers = { "go.mod" },
    settings = {
        gopls = {
            templateExtensions = { "hmtl", "tmpl" },
            gofumpt = true,
            staticcheck = true,
            semanticTokens = false,
            usePlaceholders = true,
            vulncheck = "Imports",
            analyses = {
                unusedparams = true,
                unusedvariable = true,
                unreachable = true,
                useany = true,
            },
            codelenses = {
                generate = true,
                gc_details = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true
            },
            hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = false,
                rangeVariableTypes = false,
            },
        }
    }
}
