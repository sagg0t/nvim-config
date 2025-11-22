local c = require("sigma.colors")

return {
    -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticError            = { fg = c.severity.error },
    DiagnosticWarn             = { fg = c.severity.warning },
    DiagnosticInfo             = { fg = c.severity.info },
    DiagnosticHint             = { fg = c.severity.hint },
    DiagnosticOk               = { fg = c.severity.ok },

    DiagnosticVirtualTextError = { fg = c.severity.error, bg = c.severity.bg.error },
    DiagnosticVirtualTextWarn  = { fg = c.severity.warning, bg = c.severity.bg.warning },
    DiagnosticVirtualTextInfo  = { fg = c.severity.info, bg = c.severity.bg.info },
    DiagnosticVirtualTextHint  = { fg = c.severity.hint, bg = c.severity.bg.hint },
    DiagnosticVirtualTextOk    = { fg = c.severity.ok, bg = c.severity.bg.ok },

    DiagnosticUnderlineError   = { sp = c.severity.error, undercurl = true },
    DiagnosticUnderlineWarn    = { sp = c.severity.warning, undercurl = true },
    DiagnosticUnderlineInfo    = { sp = c.severity.info, undercurl = true },
    DiagnosticUnderlineHint    = { sp = c.severity.hint, undercurl = true },
    DiagnosticUnderlineOk      = { fg = c.severity.ok, undercurl = true },

    DiagnosticSignError        = { fg = c.severity.error, bg = c.overlay.bg },
    DiagnosticSignWarn         = { fg = c.severity.warning, bg = c.overlay.bg },
    DiagnosticSignInfo         = { fg = c.severity.info, bg = c.overlay.bg },
    DiagnosticSignHint         = { fg = c.severity.hint, bg = c.overlay.bg },
    DiagnosticSignOk           = { fg = c.severity.ok, bg = c.overlay.bg },
}
