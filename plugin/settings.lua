vim.cmd "syntax enable"
vim.cmd "filetype plugin indent on"

local opt = vim.opt

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.exrc = true
opt.laststatus = 3
opt.hidden = true

opt.number = false
opt.relativenumber = false
opt.signcolumn = "no" -- always have signcolumn shown to not shift buffer text

opt.smartindent = true
opt.shiftwidth = 4   -- number of spaces when shift indenting
opt.tabstop = 4      -- number of visual spaces per tab
opt.softtabstop = 4  -- number of spaces in tab when editing
opt.expandtab = true -- tab to spaces

opt.cursorline = true
opt.background = "dark"
opt.winblend = 0
opt.termguicolors = true
-- opt.colorcolumn = 81
opt.colorcolumn = "101"

opt.showmatch = true
opt.incsearch = true
opt.hlsearch = true
-- opt.more = false

opt.showcmd = true
opt.showbreak = "+++ "

opt.scrolloff = 10
-- opt.linebreak = true
-- opt.textwidth = 80
opt.wrap = false
opt.ruler = false
opt.foldenable = false -- unfold everything by default
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.statusline = "%f %m%=%y %{&fileencoding?&fileencoding:&encoding} [%{&fileformat}] %p%% %l:%c"
opt.guicursor = "a:block-Cursor"
opt.completeopt = "menu,menuone,fuzzy,popup,noinsert"
opt.updatetime = 250
opt.timeoutlen = 500

opt.clipboard = "unnamedplus"
opt.undofile = true
opt.breakindent = true
opt.ignorecase = true
opt.smartcase = true

-- opt.fillchars = {
--     horiz     = "━",
--     horizup   = "┻",
--     horizdown = "┳",
--     vert      = "┃",
--     vertleft  = "┫",
--     vertright = "┣",
--     verthoriz = "╋",
-- }

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30
-- vim.g.netrw_liststyle = 1
-- Needed to be able to move files. Otherwise when not in the directory where vim was opened, can"t move
-- files. Maybe it tries to run the command with paths relevant to the current netrw dir, but in the root
-- dir.
-- vim.g.netrw_keepdir = 0 -- keep the current directory the same as the browsing directory.
vim.g.netrw_keepdir = 1
vim.g.netrw_list_hide = "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"
--     .. ",.\\+_templ\\.\\(go\\|txt\\)"
-- .. vim.fn["netrw_gitignore#Hide"]()
-- Enable recursive copy of directories in *nix systems
vim.g.netrw_localcopydircmd = "cp -r"

-- Enable recursive creation of directories in *nix systems
vim.g.netrw_localmkdir = "mkdir -p"

-- Enable recursive removal of directories in *nix systems
-- NOTE: we use "rm" instead of "rmdir" (default) to be able to remove non-empty directories
vim.g.netrw_localrmdir = "rm -r"

local border_icons = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
}
-- override privew func to add borders
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, preview_opts, ...)
    preview_opts = preview_opts or {}
    preview_opts.border = preview_opts.border or border_icons
    return orig_util_open_floating_preview(contents, syntax, preview_opts, ...)
end
