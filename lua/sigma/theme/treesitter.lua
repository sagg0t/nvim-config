local c = require("sigma.colors")

return {
    ["@comment.note"] = { link = "DiagnosticHint" },
    ["@comment.todo"] = { link = "DiagnosticInfo" },
    ["@comment.documentation"] = { fg = c.commentHighlight },
    ["@constant.builtin"] = { fg = c.stringSpecial },
    ["@constant.macro"] = { link = "Macro" },
    ["@constructor"] = { fg = c.property },
    ["@function.builtin"] = { fg = c.constant, bold = true },
    ["@property"] = { fg = c.property },
    ["@punctuation.special"] = { fg = c.operator, italic = true },
    ["@string.regexp"] = { fg = c.stringSpecial },
    ["@string.special.symbol"] = { fg = c.attribute },
    ["@tag.attribute"] = { fg = c.attribue },
    ["@tag.delimiter"] = { fg = c.comment },
    ["@type.builtin"] = { link = "@type" },
    ["@type.qualifier"] = { link = "StorageClass" },
    ["@variable"] = { link = "Identifier" },
    ["@variable.builtin"] = { fg = c.operator, italic = true },
    ["@variable.member"] = { link = "@property" },

    ["@markup.heading.1"] = { fg = c.keyword },
    ["@markup.heading.2"] = { fg = c.type },
    ["@markup.heading.3"] = { fg = c.stringSpecial },
    ["@markup.heading.4"] = { fg = c.proc },


    ["@lsp.type.builtin"] = { link = "@type" },
    ["@lsp.mod.readonly"] = { link = "@constant" },

    ["@lsp.typemod.keyword.documentation"] = { fg = c.commentHighlight, bold = true, italic = true },
    ["@lsp.typemod.type.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.variable.readonly"] = { link = "@constant" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@constant.builtin" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },

    -- Go
    ["@lsp.mod.defaultLibrary.go"] = { link = "@constant.builtin.go" },
    ["@lsp.mod.signature"] = { link = "@function" }, -- NOTE: non-standard mod, hence in Go block
    ["@lsp.mod.format"] = { link = "@string.special" }, -- NOTE: non-standard mod, hence in Go block

    -- Ruby
    ["@keyword.conditional.ruby"] = { fg = c.keyword, italic = true },
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
    ["@keyword.import.zig"] = { link = "Type" }
}
