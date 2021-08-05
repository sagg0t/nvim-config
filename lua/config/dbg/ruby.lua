local dap = require('dap')

local function launch()
  print('launching...')

  dap.run({
    type = 'ruby',
    request = 'launch',
    cwd = vim.fn.getcwd(),
  })
end

return {
    launch = launch,
}
