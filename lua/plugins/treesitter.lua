return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = ":TSUpdate",
        opts = {},
        config = function(opts)
            local ts = require("nvim-treesitter")

            ts.setup(opts)

            local supported_fts = ts.get_available()
            local ft_group = vim.api.nvim_create_augroup("sagg0t FileType", { clear = true })

            -- Lua is built in.
            -- Doesn't work for: markdown, embeded template, gotmpl
            vim.api.nvim_create_autocmd("FileType", {
                group = ft_group,
                pattern = supported_fts,
                callback = function(evt)
                    local ok, _ = pcall(vim.treesitter.start, evt.buf)
                    if not ok then
                        vim.notify("TS parser for " .. evt.match .. " is missing, installing...", vim.log.levels.WARN)
                        ts.install(evt.match):wait(120000)
                        pcall(vim.treesitter.start, evt.buf)
                    end
                end
            })
        end
    },
}
