local theme = require("sigma.theme")

vim.cmd.highlight("clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "sigma"

for group, opts in pairs(theme.groups) do
    vim.api.nvim_set_hl(0, group, opts)
end
