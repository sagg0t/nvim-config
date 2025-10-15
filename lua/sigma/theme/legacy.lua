local c = require("sigma.colors")

return {
    htmlTag = { fg = c.invisibleGrey },
    htmlEndTag = { link = "htmlTag" },
    htmlTagName = { fg = c.darkBlue },
    htmlArg = { fg = c.pinkWarm },

    rubyInstanceVariable = { link = "@variable.member.ruby" },
    rubyKeywordAsMethod = { link = "@function.method" },
    rubySymbol = { link = "@string.special.symbol" },

    erubyDelimiter = { link = "htmlTag" },
}
