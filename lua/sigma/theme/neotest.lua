local c = require("sigma.colors")

return {
    NeotestPassed = { fg = c.search },
    NeotestFailed = { fg = c.severity.error },
    NeotestRunning = { fg = c.string },

    NeotestAdapterName = { fg = c.keyword },
    NeotestTarget = { fg = c.keyword },
    NeotestDir = { fg = c.proc },
    NeotestFile = { fg = c.operator },
    NeotestTest = { fg = c.string },

    -- NeotestFocused = {},
    NeotestMarked = { fg = c.stringSpecial },
    NeotestSkipped = { fg = c.type },

    -- NeotestBorder = {},
    NeotestExpandMarker = { link = "Operator" },
    NeotestIndent = { link = "Operator" },
    NeotestNamespace = { fg = c.boolean },
    -- NeotestWinSelect = {},
    NeotestUnknown = { fg = c.comment },
    NeotestWatching = { fg = c.property }
}
