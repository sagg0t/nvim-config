local c = require("sigma.colors")

return {
    ["@keyword.import"] = { fg = c.keyword },
    ["@keyword.conditional"] = { link = "Conditional" },
    ["@keyword.exception"] = { link = "Exception" },
    ["@keyword.repeat"] = { link = "Repeat" },
    ["@keyword.return"] = { fg = c.keyword, bold = true },
    ["@comment.note"] = { link = "DiagnosticHint" },
    ["@comment.todo"] = { link = "DiagnosticInfo" },
    ["@comment.documentation"] = { fg = c.commentHighlight },
    ["@constant.builtin"] = { fg = c.stringSpecial },
    ["@constant.macro"] = { link = "Macro" },
    ["@constructor"] = { fg = c.property },
    ["@function.builtin"] = { fg = c.stringSpecial, bold = true },
    ["@property"] = { fg = c.property },
    ["@punctuation.special"] = { fg = c.operator, italic = true },
    ["@string.regexp"] = { fg = c.stringSpecial },
    ["@string.special.symbol"] = { fg = c.attribute },
    ["@tag.attribute"] = { fg = c.attribue },
    ["@tag.delimiter"] = { fg = c.comment },
    ["@type.builtin"] = { link = "@type" },
    ["@type.qualifier"] = { link = "StorageClass" },
    ["@variable"] = { link = "Identifier" },
    ["@variable.builtin"] = { fg = c.stringSpecial, italic = true },
    ["@variable.member"] = { link = "@property" },
    ["@module.builtin"] = { link = "@module" },

    ["@markup.heading.1"] = { fg = c.keyword },
    ["@markup.heading.2"] = { fg = c.type },
    ["@markup.heading.3"] = { fg = c.stringSpecial },
    ["@markup.heading.4"] = { fg = c.proc },


    -- ["@lsp.mod.readonly"] = { link = "@constant" },

    ["@lsp.typemod.keyword.documentation"] = { fg = c.commentHighlight, bold = true, italic = true },
    ["@lsp.typemod.variable.readonly"] = { link = "@constant" },
    ["@lsp.typemod.type.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },

    -- Go
    ["@lsp.mod.defaultLibrary.go"] = { link = "@constant.builtin.go" },
    ["@lsp.mod.signature"] = { link = "@function" }, -- NOTE: non-standard mod, hence in Go block
    ["@lsp.mod.format"] = { link = "@string.special" }, -- NOTE: non-standard mod, hence in Go block

    -- Ruby
    ["@keyword.exception.ruby"] = { fg = c.keyword, italic = true },
    ["@variable.member.ruby"] = { fg = c.overlay.accentDark },
    ["@lsp.typemod.variable.default_library"] = { link = "@variable.builtin" },

    -- Lua
    ["@constructor.lua"] = { link = "Function" },
    ["@keyword.lua"] = { fg = c.keyword },
    ["@keyword.function.lua"] = { fg = c.keyword },
    ["@lsp.typemod.class.declaration.lua"] = { standout = true },

    -- Embedded templates
    ["@keyword.embedded_template"] = { link = "@tag.delimiter" },

    -- Zig
    ["@lsp.type.builtin"] = { link = "@type" }, -- non-standard
    ["@lsp.type.escapeSequence"] = { link = "@string.special" }, -- non-standard
    ["@keyword.import.zig"] = { link = "Type" }

}
