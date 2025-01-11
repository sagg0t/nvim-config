return {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = {
        ".git/",
        "Cargo.toml"
    },
    capabilities = {
        experimental = {
            serverStatusNotification = true,
        },
    },
}
