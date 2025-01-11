---@type table<string, vim.lsp.Config>
return {
    cmd = { "ruby-lsp" },
    filetypes = { "ruby", "eruby" },
    root_markers = { "Gemfile", ".git" },
    init_options = {
        featuresConfiguration = {
            inlayHint = {
                enableAll = true
            }
        },
        experimentalFeaturesEnabled = true,
        formatter = "rubocop",
        linters = { "rubocop" },
        indexing = {
            excludedGems = {
                "brakeman",
                "bundler-audit",
                "cssbundling-rails",
                "erb_lint",
                "jsbundling-rails",
                "listen",
                "propshaft",
                "reek",
                "rubocop-performance",
                "rubocop-rails",
                "rubocop-rspec",
                "rubocop-thread_safety",
                "standardrb",
                "stimulus-rails",
                "tailwindcss-rails",
                "test-prof",
                "web-console",
                "standard",
                "standardrb",
            }
        }
    }
}
