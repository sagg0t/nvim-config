return {
    gopls = {
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                    unreachable = true,
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
                staticcheck = true,
                semanticTokens = false,
                usePlaceholders = false
            }
        }
    },

    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    -- local runtime_path = vim.split(package.path, ';')
                    -- table.insert(runtime_path, "lua/?.lua")
                    -- table.insert(runtime_path, "lua/?/init.lua")
                    -- path = runtime_path,
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

    eslint = {},
    ts_ls = {},
    jsonls = {},
    ruby_lsp = {
        filetypes = { "ruby", "eruby" },
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
    },
    rust_analyzer = {},
    bashls = {},
    clangd = {},
    neocmake = {
        root_dir = function(fname)
            return require("lspconfig").util.find_git_ancestor(fname)
        end,
        single_file_support = true,
        init_options = {
            format = {
                enable = true
            },
            lint = {
                enable = true
            },
            scan_cmake_in_package = true
        }
    },
    terraformls = {},

    tailwindcss = {
        filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "htmlangular", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte", "templ", "ruby" },
        settings = {
            tailwindCSS = {
                includeLanguages = {
                    ruby = "html"
                },
                emmetCompletions = true,
                experimental = {
                    classRegex = {
                        "['\"]([^'\"]*)['\"]",
                        "%[wW]\\[\\s*([^'\"\\[\\]]*)\\s*\\]"
                    },
                    configFile = {
                        ["config/tailwind.config.js"] = "app/{components,views}/**/*"
                    }
                }
            }
        }
    },
    cssls = {
        settings = {
            css = {
                validate = true,
                trace = {
                    server = "verbose"
                },
                lint = {
                    unknownAtRules = "ignore"
                },
                -- customData = {"/Users/sagg0t/devel/aisha/tailwind.json"}
                customData = {
                    {
                        version = 1.1,
                        atDirectives = {
                            {
                                name = "@apply",
                                description =
                                "Use the `@apply` directive to inline any existing utility classes into your own custom CSS. This is useful when you find a common utility pattern in your HTML that you’d like to extract to a new component.",
                                references = {
                                    {
                                        name = "Tailwind Documentation",
                                        url = "https://tailwindcss.com/docs/functions-and-directives#apply"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
