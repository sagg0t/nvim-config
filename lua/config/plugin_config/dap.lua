local dap = require('dap')
dap.adapters.ruby = {
  type = 'executable';
  command = 'bundle';
  args = {'exec', 'readapt', 'stdio'};
}

dap.configurations.ruby = {
  {
    type = 'ruby';
    request = 'launch';
    name = 'Rails';
    program = 'bundle';
    programArgs = {'exec', 'rails', 's'};
    useBundler = true;
  },
}

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<Leader>db', ":lua require('dap').toggle_breakpoint()", opts)
vim.api.nvim_set_keymap('n', '<Leader>dc', ":lua require('dap').continue()", opts)
vim.api.nvim_set_keymap('n', '<Leader>dr', ":lua require('dap').repl.open()<CR>", opts)

local function launch()
  print('launching...')

  dap.run({
    type = 'ruby',
    request = 'launch',
    cwd = vim.fn.getcwd(),
  })
end
