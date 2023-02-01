if true then return {} end

return {
    ruby_lsp = {
        default_config = {
             cmd = {"bundle", "exec", "ruby-lsp"},
             filetypes = { "ruby" },
             root_dir = function(fname)
               return lsp.util.find_git_ancestor(fname)
             end,
             -- settings = {}
        }
    }
}
