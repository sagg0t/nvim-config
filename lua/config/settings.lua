vim.cmd 'syntax enable'
vim.cmd 'filetype plugin indent on'

-- not available in current versio, need to wait till is available
-- for now use vim command
-- vim.g.colorscheme = 'dark_plus'
-- vim.cmd('colorscheme dark_plus')

vim.g.mapleader = ' '

vim.g.backup = false
vim.g.writebackup = false
vim.g.swapfile = false
vim.g.laststatus = 0
vim.g.hidden = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'        -- always have signcolumn shown to not shift buffer text

vim.o.smartindent = true
vim.o.shiftwidth = 2            -- number of spaces when shift indenting
vim.o.tabstop = 2               -- number of visual spaces per tab
vim.o.softtabstop = 2           -- number of spaces in tab when editing
vim.o.expandtab = true          -- tab to spaces

vim.o.cursorline = true
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.o.colorcolumn = '105'

vim.o.showmatch = true
vim.o.incsearch = true
vim.o.hlsearch = true

vim.o.showcmd = true

vim.o.linebreak = true
vim.o.textwidth = 105
vim.o.ruler = false
vim.o.foldmethod = 'indent'
vim.o.foldenable = false -- unfold everything by default
-- vim.o.statusline = '%f\ %m%=%y\ %{&fileencoding?&fileencoding:&encoding}\ [%{&fileformat}\]\ %p%%\ %l:%c'
vim.o.guicursor = 'a:block-Cursor'
-- vim.o.updatetime = 300
-- vim.g.ttimeoutlen = 0


vim.o.clipboard = 'unnamedplus'
