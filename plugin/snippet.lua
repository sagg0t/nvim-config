local snip = require("snippet")

vim.keymap.set("i", "<Tab>", function()
    if vim.snippet.active() then
        vim.snippet.jump(1)
    elseif not snip.expand() then -- try to expand snip, otherwise exec block
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Tab>", true, true, true),
            "n",
            true
        )
    end
end, { remap = true })

vim.keymap.set("i", "<S-Tab>", function()
    if vim.snippet.active() then
        vim.snippet.jump(-1)
    end
end)
