local c = require("sigma.colors")

return {
    ColorColumn = { bg = c.darkPink },
    Conceal = { link = "Comment" },
    Cursor = { bg = c.white },
    lCursor = { link = "Cursor" },
    CursorIM = { link = "Cursor" },
    CursorLine = { bg = c.overlay.light.bg },
    CursorColumn = { link = "CursorLine" },

    Directory = { fg = c.lightCyan },

    Added = { fg = c.git.add },
    Changed = { fg = c.git.change },
    Removed = { fg = c.git.delete },

    DiffAdd = { link = "Added" },
    DiffChange = { link = "Changed" },
    DiffDelete = { link = "Removed" },
    DiffText = { fg = c.fg },

    EndOfBuffer = { fg = c.greyMid },
    TermCursor = { link = "Cursor" },
    TermCursorNC = { link = "Cursor" },

    ErrorMsg = { fg = c.severity.error },
    WarningMsg = { fg = c.severity.warning },

    WinSeparator = { fg = c.greyMid, bg = c.bg },
    Folded = { fg = c.invisibleGrey },
    FoldColumn = { fg = c.overlay.fg, bg = c.overlay.bg },
    SignColumn = { fg = c.overlay.fg, bg = c.overlay.bg, },
    LineNr = { fg = c.overlay.fg, bg = c.overlay.bg },
    LineNrAbove = { link = "LineNr" },
    LineNrBelow = { link = "LineNr" },
    CursorLineNr = { fg = c.overlay.accent, bg = c.overlay.bg },
    CursorLineFold = { link = "FoldColumn" },
    CursorLineSign = { link = "SignColumn" },
    MatchParen = { fg = c.pinkNeon, bold = true, underline = true },
    ModeMsg = { fg = c.fg, bold = true },
    MsgArea = { fg = c.fg, bg = c.overlay.bg },
    MsgSeparator = { bg = c.overlay.bg },
    MoreMsg = { fg = c.orange, bg = c.overlay.bg },
    NonText = { fg = c.greyMid },
    -- Normal = { fg = c.fg, bg = c.bg },
    Normal = { fg = c.fg, bg = c.none },
    NormalNC = { link = "Normal" },

    NormalFloat = { bg = c.overlay.bg },
    FloatBorder = { fg = c.greyMid, bg = c.overlay.bg },
    FloatTitle = { fg = c.overlay.accent, bg = c.overlay.bg },
    FloatFooter = { link = "FloatTitle" },

    Pmenu = { bg = c.overlay.bg },
    PmenuSel = { bg = c.darkPink },
    PmenuKind = { fg = c.invisibleGrey },
    PmenuKindSel = { fg = c.invisibleGrey, bg = c.darkPink },
    PmenuExtra = { fg = c.whiteIsh },
    PmenuExtraSel = { fg = c.whiteIsh, bg = c.darkPink },
    PmenuSbar = { bg = c.overlay.bg },
    PmenuThumb = { bg = c.darkCyan },
    PmenuMatch = { fg = c.blueIce, bold = true },

    Question = { link = "Comment" },

    QuickFixLine = { bold = true },

    Search = { fg = c.fg, bg = c.green },
    CurSearch = { fg = c.bg, bg = c.lightYellow },
    IncSearch = { bg = c.green },
    Substitute = { fg = c.fg, bg = c.pinkNeon },

    SpecialKey = { fg = c.greyMid },
    SpellBad = { sp = c.severity.error, undercurl = true },
    SpellCap = { sp = c.severity.warning, undercurl = true },
    SpellLocal = { sp = c.severity.info, undercurl = true },
    SpellRare = { sp = c.severity.hint, undercurl = true },

    StatusLine = { fg = c.fg, bg = c.overlay.bg },
    StatusLineNC = { link = "StatusLine" },

    TabLine = { fg = c.overlay.fg, bg = c.overlay.bg },
    TabLineFill = { bg = c.overlay.bg },
    TabLineSel = { fg = c.overlay.bg, bg = c.darkCyan },

    Title = { fg = c.whiteIsh },

    Visual = { bg = c.selection },
    VisualNOS = { bg = c.selection },

    Whitespace = { fg = c.greyMid },
    WildMenu = { fg = c.whiteIsh },
    WinBar = { link = "TabLine" },
    WinBarNC = { link = "Tabline" },
    Scrollbar = { fg = c.darkCyan },
    Menu = { link = "UNSET" },    -- Mostly GUI only
    Tooltip = { link = "UNSET" }, -- Mostly GUI only

    -- :h syntax.txt:184
    Comment = { fg = c.invisibleGrey, italic = true },

    Constant = { fg = c.darkCyan, bold = true },
    String = { fg = c.lightYellow },
    Character = { fg = c.orange },
    Number = { fg = c.pinkDimmed },
    Float = { link = "Number" },
    Boolean = { fg = c.lightPurple },

    Identifier = { fg = c.whiteIsh },
    Function = { fg = c.lightCyan },

    Statement = { fg = c.pinkNeon },
    Conditional = { fg = c.pinkNeon },
    Repeat = { link = "Statement" },
    Label = { link = "Conditional" },
    Operator = { fg = c.bleachedCyan, bold = true },
    Keyword = { link = "Statement" },
    Exception = { fg = c.pinkNeon, italic = true },

    PreProc = { fg = c.pinkDimmed },
    Include = { fg = c.pinkDimmed, bold = true },
    Define = { link = "PreProc" },
    Macro = { link = "PreProc" },
    PreCondit = { link = "PreProc" },

    Type = { fg = c.blueIce },
    StorageClass = { fg = c.pinkNeon, italic = true },
    Structure = { fg = c.goldenrod },
    Typedef = { link = "Type" },

    Special = { fg = c.orange },
    SpecialChar = { fg = c.orange },
    Tag = { fg = c.darkBlue },
    Delimiter = { link = "Operator" },
    SpecialComment = { fg = c.invisibleGrey, bold = true },
    Debug = { fg = c.pinkNeon, italic = true, underline = true },

    Underlined = { underline = true },
    Bold = { bold = true },

    Ignore = { link = "Comment" },

    Error = { fg = c.severity.error },
    Todo = { fg = c.severity.info },
}
