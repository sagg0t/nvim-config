local cwd = vim.fn.getcwd()
local telescope_ctx = { cwd = cwd }

local function set_cwd(path)
    telescope_ctx.cwd = path
end

return {
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        cmd = "Telescope",
        keys = {
            { "<Leader>ff", function() require("telescope.builtin").find_files(telescope_ctx) end },
            { "<Leader>ft", function() require("telescope.builtin").live_grep(telescope_ctx) end },
            { "<Leader>fs", "<CMD>Telescope lsp_document_symbols<CR>" },
            { "<Leader>fb", "<CMD>Telescope buffers<CR>" },
            { "<Leader>fo", "<CMD>Telescope oldfiles<CR>" },
            { "<Leader>fh", "<CMD>Telescope help_tags<CR>" },
            { "<Leader>fk", "<CMD>Telescope keymaps<CR>" },
            { "<Leader>fO", "<CMD>Telescope vim_options<CR>" },
            { "<Leader>f/", "<CMD>Telescope current_buffer_fuzzy_find<CR>" },
            { "<Leader>f?", "<CMD>Telescope search_history<CR>" },
            { "<Leader>f;", "<CMD>Telescope command_history<CR>" },
            { "<Leader>fc", "<CMD>Telescope commands<CR>" },
            { "<Leader>fw", function() require("telescope").extensions.git_worktree.git_worktrees() end },
        },
        dependencies = {
            { "nvim-lua/popup.nvim" },
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
                winblend = 0,
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                -- layout_strategy = "horizontal",
                file_ignore_patterns = { "node_modules" },
                -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            },


            pickers = {
                live_grep = {
                    layout_strategy = "center",
                    prompt_title = "",
                    results_title = "",
                    preview_title = "",
                    layout_config = {
                        width = function(_, max_columns, _)
                            return math.min(max_columns - 3, 80)
                        end,
                    }
                },
                find_files = {
                    layout_strategy = "center",
                    prompt_title = "",
                    results_title = "",
                    preview_title = "",
                    layout_config = {
                        width = function(_, max_columns, _)
                            return math.min(max_columns - 3, 70)
                        end,
                        height = function(_, _, max_lines)
                            return math.min(max_lines - 4, 25)
                        end,
                    },
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
            telescope.load_extension("dap")
            telescope.load_extension("media_files")
            telescope.load_extension("git_worktree")
            telescope.load_extension("ui-select")

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
        "nvim-telescope/telescope-media-files.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" }
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        dependencies = { "nvim-telescope/telescope.nvim" }
    },

    {
        "nvim-telescope/telescope-dap.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" }
    },

    {
        "nvim-telescope/telescope-ui-select.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" }
    }

}
