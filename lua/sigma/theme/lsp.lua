local c = require("sigma.colors")
local u = require("sigma.util")

return {
    LspInlayHint = { fg = c.comment },
    LspCodeLens = { fg = c.muted },
    LspReferenceWrite = { bg = u.darken(c.keyword, 0.4) },
}
