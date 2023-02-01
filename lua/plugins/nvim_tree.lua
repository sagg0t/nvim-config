return {
    {
        "kyazdani42/nvim-tree.lua",
        keys = {
            { '<C-b>', ':NvimTreeToggle<CR>', noremap = true, silent = true }
        },
        opts = {
            disable_netrw = true,
            hijack_cursor = true,
            view = {
                width = 35,
                side = 'right',
                mappings = {
                    custom_only = true,
                    list = mappings
                }
            },
            renderer = {
                indent_markers = {
                    enable = false
                },
                icons = {
                    show = {
                        git = false,
                        folder = false,
                        folder_arrow = true,
                        file = false
                    },
                    glyphs = {
                        folder = {
                            arrow_open = '',
                            arrow_closed = '',
                            default = '',
                            open = '',
                            empty = '',
                            empty_open = ''
                        }
                    },
                },
                special_files = { "Makefile", "README.md", "readme.md", "Gemfile", "Gemfile.lock" },
            },
            hijack_directories = {
                enable = true,
                auto_open = true,
            },
            filters = {
                dotfiles = true
            },
            git = {
                ignore = false
            }
        },
        config = function(_, opts)
            local tree_cb = require('nvim-tree.config').nvim_tree_callback
            local mappings = {
                { key = { '<CR>', 'o', '<2-LeftMouse>' }, cb = tree_cb('edit') },
                { key = 'C', cb = tree_cb('cd') },
                { key = 's', cb = tree_cb('vsplit') },
                { key = 'i', cb = tree_cb('split') },
                { key = 't', cb = tree_cb('tabnew') },
                { key = '<', cb = tree_cb('prev_sibling') },
                { key = '>', cb = tree_cb('next_sibling') },
                { key = 'P', cb = tree_cb('parent_node') },
                { key = 'x', cb = tree_cb('close_node') },
                { key = '<S-CR>', cb = tree_cb('close_node') },
                { key = '<Tab>', cb = tree_cb('preview') },
                { key = 'K', cb = tree_cb('first_sibling') },
                { key = 'J', cb = tree_cb('last_sibling') },
                { key = 'I', cb = tree_cb('toggle_git_ignored') },
                { key = 'H', cb = tree_cb('toggle_dotfiles') },
                { key = 'R', cb = tree_cb('refresh') },
                { key = 'a', cb = tree_cb('create') },
                { key = 'd', cb = tree_cb('remove') },
                { key = 'r', cb = tree_cb('rename') },
                { key = '<C-r>', cb = tree_cb('full_rename') },
                -- { key = 'x',                            cb = tree_cb('cut') },
                { key = 'c', cb = tree_cb('copy') },
                { key = 'p', cb = tree_cb('paste') },
                { key = 'y', cb = tree_cb('copy_name') },
                { key = 'Y', cb = tree_cb('copy_path') },
                { key = 'gy', cb = tree_cb('copy_absolute_path') },
                { key = '[c', cb = tree_cb('prev_git_item') },
                { key = ']c', cb = tree_cb('next_git_item') },
                { key = 'U', cb = tree_cb('dir_up') },
                { key = 'q', cb = tree_cb('close') },
                { key = '?', cb = tree_cb('toggle_help') },
            }

            opts.view.mappings.list = mappings

            require('nvim-tree').setup(opts)
        end,
        
    }
}
