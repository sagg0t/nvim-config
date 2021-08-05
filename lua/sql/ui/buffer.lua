local Buffer = {
  handle = nil
}
Buffer.__index = Buffer

function Buffer:new(handle)
  local this = {
    handle = handle,
  }

  setmetatable(this, self)

  return this
end

function Buffer:get_option(name)
  vim.api.nvim_buf_get_option(self.handle, name)
end

function Buffer:set_option(name, value)
  vim.api.nvim_buf_set_option(self.handle, name, value)
end

function Buffer:set_name(name)
  vim.api.nvim_buf_set_name(self.handle, name)
end

function Buffer:set_filetype(ft)
  vim.cmd("setlocal filetype=" .. ft)
end

return Buffer
