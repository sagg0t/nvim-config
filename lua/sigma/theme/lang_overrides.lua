local c = require("sigma.colors")

return {
    htmlTag = { fg = c.comment },
    htmlEndTag = { link = "htmlTag" },
    htmlTagName = { fg = c.tag },
    htmlArg = { fg = c.propertyAlt },

    rubyInstanceVariable = { link = "@variable.member.ruby" },
    rubyKeywordAsMethod = { link = "@function.method" },
    rubySymbol = { link = "@string.special.symbol" },

    erubyDelimiter = { link = "htmlTag" },

    qfLineNr = { fg = c.number },
    qfText = { fg = c.fg },
    qfSeparator1 = { link = "Comment" },
    qfSeparator2 = { link = "Comment" },

    logBrackets = { link = "Operator" },

    gitrebasePick = { link = "Function" },
    gitrebaseCommit = { link = "Number" },
    gitrebaseHash = { link = "Number" },
    gitrebaseSummary = { link = "Normal" },
}
