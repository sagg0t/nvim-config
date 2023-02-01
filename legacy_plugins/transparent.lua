local transparent = require("transparent")

-- You can also set the groups option to override the default groups.
--
-- The default groups: Normal NormalNC Comment Constant Special Identifier
-- Statement PreProc Type Underlined Todo String Function Conditional Repeat
-- Operator Structure LineNr NonText SignColumn CursorLineNr.

transparent.setup({
  -- enable = true, -- boolean: enable transparent
  -- extra_groups = { -- table/string: additional groups that should be cleared
  --   -- In particular, when you set it to 'all', that means all available groups
  --
  --   -- example of akinsho/nvim-bufferline.lua
  --   "BufferLineTabClose",
  --   "BufferlineBufferSelected",
  --   "BufferLineFill",
  --   "BufferLineBackground",
  --   "BufferLineSeparator",
  --   "BufferLineIndicatorSelected",
  -- },
  exclude = {}, -- table: groups you don't want to clear
})
