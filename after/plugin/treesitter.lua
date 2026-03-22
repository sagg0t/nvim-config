local cmd_group = vim.api.nvim_create_augroup("sagg0t.treesitter", { clear = true })

-- NOTE: must be before vim.pack.add
vim.api.nvim_create_autocmd({ "PackChanged" }, {
    group = cmd_group,
    callback = function(evt)
        local name, kind = evt.data.spec.name, evt.data.kind
        if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
            vim.cmd("TSUpdate")
        end
    end
})

vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
    },
}, { load = true })

local ts = require("nvim-treesitter")

--- @type table<string, string> -- <ft, lang> 
local ft_map = {
    env = "bash",
    gitconfig = "git_config",
}

for ft, lang in pairs(ft_map) do
    vim.treesitter.language.register(lang, ft)
end

local supported_fts = vim.iter({
    ts.get_available(),
    vim.tbl_keys(ft_map),
}):flatten():totable()

-- Lua is built in.
-- Doesn't work for: markdown, embeded template, gotmpl
vim.api.nvim_create_autocmd("FileType", {
    group = cmd_group,
    pattern = supported_fts,
    callback = function(evt)
        if vim.bo[evt.buf].filetype ~= "bigfile" then
            local ok, _ = pcall(vim.treesitter.start, evt.buf)
            if not ok then
                vim.notify("TS parser for " .. evt.match .. " is missing, installing...", vim.log.levels.INFO)
                local lang = ft_map[evt.match] or evt.match
                ts.install(lang):wait(120000)
                pcall(vim.treesitter.start, evt.buf)
            end
        end
    end
})

vim.api.nvim_create_autocmd("FileType", {
    group = cmd_group,
    pattern = { "gitcommit" },
    callback = function(evt)
        vim.bo[evt.buf].syntax = "on"
    end,
})
