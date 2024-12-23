return {
    {
        "lowitea/aw-watcher.nvim",
        opts = {
            bucket = {
                hostname = nil, -- by default hostname of computer
                name = nil, -- by default "aw-watcher-neovim_" .. bucket.hostname
            },
            aw_server = {
                host = "127.0.0.1",
                port = 5600,
                ssl_enable = false,
                pulsetime = 30,
            },
        },
    },
}
