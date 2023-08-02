vim.cmd 'syntax enable'
vim.cmd 'filetype plugin indent on'

vim.g.mapleader = " "

local opt = vim.opt
-- not available in current versio, need to wait till is available
-- for now use optommand
-- opt.colorscheme = 'dark_plus'
-- vim.cmd('colorscheme dark_plus')

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.laststatus = 3
opt.hidden = true

opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'        -- always have signcolumn shown to not shift buffer text

opt.smartindent = true
opt.shiftwidth = 4            -- number of spaces when shift indenting
opt.tabstop = 4               -- number of visual spaces per tab
opt.softtabstop = 4           -- number of spaces in tab when editing
opt.expandtab = true          -- tab to spaces

opt.cursorline = true
opt.background = 'dark'
opt.termguicolors = true
opt.colorcolumn = '105'

opt.showmatch = true
opt.incsearch = true
opt.hlsearch = true

opt.showcmd = true

opt.linebreak = true
opt.textwidth = 105
opt.ruler = false
opt.foldmethod = 'indent'
opt.foldenable = false -- unfold everything by default
-- opt.statusline = '%f\ %m%=%y\ %{&fileencoding?&fileencoding:&encoding}\ [%{&fileformat}\]\ %p%%\ %l:%c'
opt.guicursor = 'a:block-Cursor'
opt.updatetime = 250
opt.ttimeoutlen = 0


opt.clipboard = 'unnamedplus'

-- opt.fillchars = {
--     horiz     = '━',
--     horizup   = '┻',
--     horizdown = '┳',
--     vert      = '┃',
--     vertleft  = '┫',
--     vertright = '┣',
--     verthoriz = '╋',
-- }

vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30
vim.g.netrw_liststyle = 3
vim.g.netrw_list_hide = "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"
vim.g.netrw_localcopydircmd = "cp -r"


return {}
