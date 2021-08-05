local api = vim.api
Buffer = require("sql.ui.buffer")
Utils = require("sql.utils")


function OPEN()
  vim.cmd('tabnew')
  buffer = Buffer:new(vim.api.nvim_get_current_buf())
  buffer:set_filetype('sql')
  buffer:set_name('testname')
end
