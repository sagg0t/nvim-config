if true then return {} end

local cwd = vim.fn.getcwd()
local telescope_ctx = { cwd = cwd }

local function set_cwd(path)
    telescope_ctx.cwd = path
end

return {
    {
        "nvim-telescope/telescope.nvim",
        enabled = false,
        lazy = true,
        cmd = "Telescope",
        keys = {
            {
                "<Leader>ff",
                function() require("telescope.builtin").find_files(telescope_ctx) end,
                desc = "files"
            },
            {
                "<Leader>fF",
                function()
                    local ctx = vim.tbl_deep_extend("force", telescope_ctx, { hidden = true })
                    require("telescope.builtin").find_files(ctx)
                end,
                desc = "files (with hidden)"
            },
            {
                "<Leader>ft",
                function() require("telescope.builtin").live_grep(telescope_ctx) end,
                desc = "text"
            },
            {
                "<Leader>fT",
                function()
                    local ctx = vim.tbl_deep_extend("force", telescope_ctx, { hidden = true })
                    require("telescope.builtin").live_grep(ctx)
                end,
                desc = "text (with hidden)"
            },
            {
                "<Leader>fb",
                "<CMD>Telescope buffers<CR>",
                desc = "buffers"
            },
            {
                "<Leader>fh",
                "<CMD>Telescope help_tags<CR>",
                desc = "vim help"
            },
            {
                "<Leader>fH",
                "<CMD>Telescope highlights<CR>",
                desc = "vim highlights"
            },
            {
                "<Leader>fk",
                "<CMD>Telescope keymaps<CR>",
                desc = "keymaps"
            },
            {
                "<Leader>fO",
                "<CMD>Telescope vim_options<CR>",
                desc = "vim options"
            },
            {
                "<Leader>f/",
                "<CMD>Telescope current_buffer_fuzzy_find<CR>",
                desc = "buf fuzzy find"
            },
            {
                "<Leader>f?",
                "<CMD>Telescope search_history<CR>",
                desc = "search history"
            },
            {
                "<Leader>f;",
                "<CMD>Telescope command_history<CR>",
                desc = "command history"
            },
            {
                "<Leader>fc",
                "<CMD>Telescope commands<CR>",
                desc = "commands"
            },
            {
                "<Leader>fw",
                function()
                    require("telescope").extensions.git_worktree.git_worktrees()
                end,
                desc = "Git worktree"
            },
        },
        dependencies = {
            { "nvim-lua/plenary.nvim" }
        },
        opts = {
            defaults = {
                borderchars = {
                    prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    results = { "─", "│", "─", "│", "╭", "╮", "┤", "├" },
                    preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                },
                prompt_prefix = " ",
                selection_caret = " ",
                entry_prefix = "  ",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                -- layout_strategy = "horizontal",
                file_ignore_patterns = { "node_modules" },
                -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            },


            pickers = {
                live_grep = {
                    theme = "ivy"
                    -- layout_strategy = "center",
                    -- prompt_title = "",
                    -- results_title = "",
                    -- preview_title = "",
                    -- layout_config = {
                    --     width = function(_, max_columns, _)
                    --         return math.min(max_columns - 3, 80)
                    --     end,
                    -- }
                },
                find_files = {
                    theme = "ivy"
                    -- layout_strategy = "center",
                    -- prompt_title = "",
                    -- results_title = "",
                    -- preview_title = "",
                    -- layout_config = {
                    --     width = function(_, max_columns, _)
                    --         return math.min(max_columns - 3, 70)
                    --     end,
                    --     height = function(_, _, max_lines)
                    --         return math.min(max_lines - 4, 25)
                    --     end,
                    -- },
                },
            },


            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true
                },
            }
        },
        config = function(_, opts)
            local telescope = require("telescope")

            telescope.setup(opts)

            telescope.load_extension("fzf")
            telescope.load_extension("git_worktree")

            local Worktree = require("git-worktree")
            Worktree.on_tree_change(function(op, metadata)
                if op == Worktree.Operations.Switch then
                    set_cwd(metadata.path)
                    print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
                end
            end)
        end
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        enabled = false,
        lazy = true,
        build = "make",
        dependencies = { "nvim-telescope/telescope.nvim" }
    },
}
