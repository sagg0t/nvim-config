local opt = vim.opt

vim.cmd.syntax("enable")
vim.cmd.filetype("plugin indent on")

opt.backup = false
opt.writebackup = false
opt.swapfile = false
-- opt.exrc = true
opt.laststatus = 3
opt.hidden = true

opt.number = false
opt.relativenumber = false
opt.signcolumn = "auto"

opt.smartindent = true
opt.shiftwidth = 4   -- number of spaces when shift indenting
opt.tabstop = 4      -- number of visual spaces per tab
opt.softtabstop = 4  -- number of spaces in tab when editing
opt.expandtab = true -- tab to spaces

opt.cursorline = true
opt.background = "dark"
opt.winblend = 0
opt.termguicolors = true
-- opt.colorcolumn = "101"

opt.showmatch = true
opt.incsearch = true
opt.hlsearch = true
-- opt.more = false

opt.showcmd = true
opt.showbreak = "++"

opt.scrolloff = 10
-- opt.linebreak = true
-- opt.textwidth = 80
opt.wrap = false
opt.ruler = false
opt.foldenable = false -- unfold everything by default
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- see: plugin/statusline.lua
-- opt.statusline = "%f %m%=%y %{&fileencoding?&fileencoding:&encoding} [%{&fileformat}] %p%% %l:%c"
opt.guicursor = "a:block-Cursor"
opt.updatetime = 250
opt.timeoutlen = 500

opt.completeopt = "menuone,fuzzy,popup,noinsert"
opt.pumheight = 20

opt.clipboard = "unnamedplus"
opt.undofile = true
opt.breakindent = true
opt.ignorecase = true
opt.smartcase = true

vim.cmd.colorscheme("sigma")
opt.listchars = {
  tab = "→ ",
  space = "·",
  nbsp = "␣",
  trail = "·",
  eol = "␤",
  extends = "▶",
  precedes = "◀",
  conceal = "│",
}
opt.list = false

vim.o.winborder = "solid"

opt.fillchars = {
    eob = " ",
--     horiz     = "━",
--     horizup   = "┻",
--     horizdown = "┳",
--     vert      = "┃",
--     vertleft  = "┫",
--     vertright = "┣",
--     verthoriz = "╋",
}
