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
