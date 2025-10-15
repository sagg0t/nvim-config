local c = require("sigma.colors")

return {
    NeotestPassed = { fg = c.green },
    NeotestFailed = { fg = c.severity.error },
    NeotestRunning = { fg = c.lightYellow },

    NeotestAdapterName = { fg = c.pinkNeon },
    NeotestTarget = { fg = c.pinkNeon },
    NeotestDir = { fg = c.lightCyan },
    NeotestFile = { fg = c.bleachedCyan },
    NeotestTest = { fg = c.lightYellow },

    -- NeotestFocused = {},
    NeotestMarked = { fg = c.orange },
    NeotestSkipped = { fg = c.blueIce },

    -- NeotestBorder = {},
    NeotestExpandMarker = { link = "Operator" },
    NeotestIndent = { link = "Operator" },
    NeotestNamespace = { fg = c.lightPurple },
    -- NeotestWinSelect = {},
    NeotestUnknown = { fg = c.invisibleGrey },
    NeotestWatching = { fg = c.lightBlue }
}
