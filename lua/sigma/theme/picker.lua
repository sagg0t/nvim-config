local c = require("sigma.colors")

return {
    PickerDir = { fg = c.comment },

    MiniPickBorder = { link = "FloatBorder" }, -- window border.
    -- MiniPickBorderBusy = {}, -- window border while picker is busy processing.
    -- MiniPickBorderText = {}, -- non-prompt on border.
    -- MiniPickCursor = {}, -- cursor during active picker (hidden by default).
    -- MiniPickIconDirectory = {}, -- default icon for directory.
    -- MiniPickIconFile = {}, -- default icon for file.
    MiniPickHeader = { link = "Title" }, -- headers in info buffer and previews.
    -- MiniPickMatchCurrent = {}, -- current matched item.
    MiniPickMatchMarked = { fg = c.overlay.accent }, -- marked matched items.
    MiniPickMatchRanges = { link = "PmenuMatch" }, -- ranges matching query elements.
    -- MiniPickNormal = {}, -- basic foreground/background highlighting.
    MiniPickPreviewLine = { link = "Visual" }, -- target line in preview.
    MiniPickPreviewRegion = { link = "Visual" }, -- target region in preview.
    MiniPickPrompt = { bg = c.overlay.bg }, -- prompt.
    MiniPickPromptCaret = { fg = c.stringSpecial, bg = c.overlay.bg, bold = true }, -- caret in prompt.
    MiniPickPromptPrefix = { fg = c.stringSpecial, bg = c.overlay.bg, bold = true }, -- prefix of the prompt.
}
