---------------------------------
----------- VIM-TEST ------------
---------------------------------
-- vim.g['test#strategy'] = 'tslime'
-- vim.g.tslime_always_current_session = 1
-- vim.g.tslime_autoset_pane = 1
--
-- vim.g.tslime = {
--   ['session'] = '0',
--   ['window'] = 3,
-- }

-- vim.api.nvim_exec(
--   [[
--     let g:tslime = {}
--     let sessions = split(system('tmux list-panes -F "active=#{pane_active} #{session_name},#{window_index},#{pane_index}" | grep "active=1" | cut -d " " -f 2 | tr , "\n"'), '\n')
--     let g:tslime['session'] = sessions[0]
--     let g:tslime['window'] = 3
--     let g:tslime['pane'] = 0
--   ]],
--   true
-- )

-- test invocation
-- vim.api.nvim_set_keymap('n', '<Leader>ta', ':TestSuite<CR>', default_opts)
-- vim.api.nvim_set_keymap('n', '<Leader>tf', ':TestFile<CR>', default_opts)
-- vim.api.nvim_set_keymap('n', '<Leader>tn', ':TestNearest<CR>', default_opts)



---------------------------------
---------- VIM-ULTEST -----------
---------------------------------
local ultest = require('ultest')
vim.g.ultest_max_threads = 5
vim.g.ultest_use_pty = 1

ultest.setup({})

-- vim.api.nvim_set_keymap('n',  '', '<Plug>(ultest-next-fail)', default_opts)      -- Jump to next failed test.
-- vim.api.nvim_set_keymap('n',  '', '<Plug>(ultest-prev-fail)', default_opts)      -- Jump to previous failed test.
vim.api.nvim_set_keymap('n',  '<Leader>tf', '<Plug>(ultest-run-file)', {})       -- Run all tests in a file.
vim.api.nvim_set_keymap('n',  '<Leader>tn', '<Plug>(ultest-run-nearest)', {})    -- Run test closest to the cursor.
vim.api.nvim_set_keymap('n',  '<Leader>tso', '<cmd>UltestSummary<CR>', default_opts) -- Toggle the summary window between open and closed
-- vim.api.nvim_set_keymap('n',  '<Leader>tsj', '<Plug>(ultest-summary-jump)', default_opts)   -- Jump to the summary window (opening if it isn't already)
-- vim.api.nvim_set_keymap('n',  '<Leader>tos', '<Plug>(ultest-output-show)', default_opts)    -- Show error output of the nearest test. (Will jump to popup window in Vim)
-- vim.api.nvim_set_keymap('n',  '', '<Plug>(ultest-output-jump)', default_opts)    -- Show error output of the nearest test. (Same behabviour as <Plug>(ultest-output-show) in Vim)
-- vim.api.nvim_set_keymap('n',  '<Leader>ta', '<Plug>(ultest-attach)', default_opts)         -- Attach to the nearest test's running process.
-- vim.api.nvim_set_keymap('n',  '', '<Plug>(ultest-stop-file)', default_opts)      -- Stop all running jobs for current file
-- vim.api.nvim_set_keymap('n',  '', '<Plug>(ultest-stop-nearest)', default_opts)   -- Stop any running jobs for nearest test
-- vim.api.nvim_set_keymap('n',  '', '<Plug>(ultest-debug)', default_opts)          -- Debug the current file with nvim-dap
-- vim.api.nvim_set_keymap('n',  '', '<Plug>(ultest-debug-nearest)', default_opts)  -- Debug the nearest test with nvim-dap
