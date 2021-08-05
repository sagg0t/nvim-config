local snippets = require('snippets')

snippets.snippets = {
    ruby = {
      bb = 'binding.pry';
    }
}

vim.g.completion_enable_snippet = 'snippets.nvim'

-- Set completeopt to have a better completion experience
vim.cmd('set completeopt=menuone,noinsert,noselect')
