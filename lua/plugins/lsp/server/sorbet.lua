if true then return {} end

return {
    sorbet = {
        cmd = { 'bundle', 'exec', 'srb', 'tc', '--lsp', '--disable-watchman' }
    }
}
