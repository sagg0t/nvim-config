---@type table<string, vim.lsp.Config>
return {
    cmd = { "tailwindcss-language-server", "--stdio" },
    -- filetypes copied and adjusted from tailwindcss-intellisense
    filetypes = {
        -- html
        "aspnetcorerazor",
        "astro",
        "astro-markdown",
        "blade",
        "clojure",
        "django-html",
        "htmldjango",
        "edge",
        "eelixir", -- vim ft
        "elixir",
        "ejs",
        "erb",
        "eruby", -- vim ft
        "gohtml",
        "gohtmltmpl",
        "haml",
        "handlebars",
        "hbs",
        "html",
        "htmlangular",
        "html-eex",
        "heex",
        "jade",
        "leaf",
        "liquid",
        "markdown",
        "mdx",
        "mustache",
        "njk",
        "nunjucks",
        "php",
        "razor",
        "ruby",
        "slim",
        "twig",
        -- css
        "css",
        "less",
        "postcss",
        "sass",
        "scss",
        "stylus",
        "sugarss",
        -- js
        "javascript",
        "javascriptreact",
        "reason",
        "rescript",
        "typescript",
        "typescriptreact",
        -- mixed
        "vue",
        "svelte",
        "templ",
    },
    settings = {
        tailwindCSS = {
            validate = true,
            lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidScreen = "error",
                invalidVariant = "error",
                invalidConfigPath = "error",
                invalidTailwindDirective = "error",
                recommendedVariantOrder = "warning",
            },
            classAttributes = {
                "class",
                "className",
                "class:list",
                "classList",
                "ngClass",
            },
            includeLanguages = {
                eelixir = "html-eex",
                eruby = "erb",
                templ = "html",
                htmlangular = "html",
                ruby = "html"
            },

            -- emmetCompletions = true,
            -- experimental = {
            --     classRegex = {
            --         "['\"]([^'\"]*)['\"]",
            --         "%[wW]\\[\\s*([^'\"\\[\\]]*)\\s*\\]"
            --     },
            --     configFile = "config/tailwind.config.js"
            -- }
        },
    },
}