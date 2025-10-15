local c = require("sigma.colors")

return {
    TelescopeNormal         = { fg = c.fg, bg = c.overlay.bg },
    TelescopeBorder         = { fg = c.overlay.bg, bg = c.overlay.bg },

    TelescopePromptNormal   = { fg = c.fg, bg = c.overlay.bg },
    TelescopePromptBorder   = { fg = c.overlay.bg, bg = c.overlay.bg },
    TelescopePromptTitle    = { fg = c.overlay.bg, bg = c.overlay.bg },
    TelescopePromptPrefix   = { fg = c.lightCyan },
    TelescopePromptCounter  = { link = "TelescopePromptPrefix" },

    TelescopePreviewNormal  = { bg = c.deadCyan },
    TelescopePreviewBorder  = { fg = c.deadCyan, bg = c.deadCyan },
    TelescopePreviewTitle   = { bg = c.deadCyan },

    TelescopeMatching       = { fg = c.pinkNeon },
    TelescopeSelection      = { bg = c.darkPink },
    TelescopeSelectionCaret = { fg = c.pinkNeon, bg = c.darkPink },
}
