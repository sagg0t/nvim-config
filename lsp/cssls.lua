---@type table<string, vim.lsp.Config>
return {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_markers = { "package.json", ".git/" },
    init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
    settings = {
        css = {
            validate = true,
            trace = {
                server = "verbose",
            },
            lint = {
                unknownAtRules = "ignore",
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
        },
        scss = { validate = true },
        less = { validate = true },
    },
}
