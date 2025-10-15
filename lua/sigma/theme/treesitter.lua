local c = require("sigma.colors")

return {
    ["@comment.note"] = { link = "DiagnosticHint" },
    ["@comment.todo"] = { link = "DiagnosticInfo" },
    ["@conditional"] = { link = "Conditional" },
    ["@constant"] = { fg = c.olive },
    ["@constant.builtin"] = { fg = c.orange },
    ["@constant.macro"] = { link = "Macro" },
    ["@constructor"] = { fg = c.lightBlue },
    -- ["@function.builtin"] = { link = "Operator" },
    ["@function.builtin"] = { fg = c.olive, bold = true },
    ["@property"] = { fg = c.lightBlue },
    ["@punctuation.special"] = { fg = c.bleachedCyan, italic = true },
    ["@string.regexp"] = { fg = c.orange },
    ["@string.special.symbol"] = { fg = c.pinkWarm },
    ["@tag.attribute"] = { fg = c.pinkWarm },
    ["@tag.delimiter"] = { fg = c.invisibleGrey },
    ["@type.builtin"] = { link = "Type" },
    ["@type.qualifier"] = { link = "StorageClass" },
    ["@variable"] = { link = "Identifier" },
    ["@variable.builtin"] = { fg = c.bleachedCyan, italic = true },
    ["@variable.member"] = { link = "@property" },

    -- Go
    ["@type.builtin.go"] = { fg = c.pinkWarm, italic = true },
    ["@lsp.typemod.type.defaultLibrary.go"] = { link = "@type.builtin.go" },
    ["@lsp.mod.defaultLibrary.go"] = { link = "@constant.builtin.go" },

    -- Ruby
    ["@keyword.conditional.ruby"] = { fg = c.pinkNeon, italic = true },
    ["@variable.member.ruby"] = { fg = c.darkCyan },
    ["@lsp.typemod.variable.default_library"] = { link = "@variable.builtin" },

    -- Lua
    ["@constructor.lua"] = { link = "Function" },

    -- Embedded templates
    ["@keyword.embedded_template"] = { link = "@tag.delimiter" },

    ["@lsp.typemod.variable.readonly"] = { link = "@constant" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@constant.builtin" },

    ["@lsp.type.builtin"] = { link = "Type" },
    ["@lsp.typemod.type.defaultLibrary"] = { link = "@type.builtin" },

    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },

    -- Zig
    ["@keyword.import.zig"] = { link = "Type" }
}
