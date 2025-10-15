local c = require("sigma.colors")
local u = require("sigma.util")

return {
    -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticError            = { fg = c.severity.error },
    DiagnosticWarn             = { fg = c.severity.warning },
    DiagnosticInfo             = { fg = c.severity.info },
    DiagnosticHint             = { fg = c.severity.hint },
    DiagnosticOk               = { fg = c.severity.ok },

    DiagnosticVirtualTextError = { fg = c.severity.error, bg = u.darken(c.severity.error, 0.1) },
    DiagnosticVirtualTextWarn  = { fg = c.severity.warning, bg = u.darken(c.severity.warning, 0.1) },
    DiagnosticVirtualTextInfo  = { fg = c.severity.info, bg = u.darken(c.severity.info, 0.1) },
    DiagnosticVirtualTextHint  = { fg = c.severity.hint, bg = u.darken(c.severity.hint, 0.1) },
    DiagnosticVirtualTextOk    = { fg = c.severity.ok, bg = u.darken(c.severity.ok, 0.1) },

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
