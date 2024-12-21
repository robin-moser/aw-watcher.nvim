---@class AWClientConfig
---@field host string?
---@field port number?
---@field ssl_enable boolean?
---@field pulsetime number?

---@class BucketConfig
---@field hostname string?
---@field name string?

---@class Config
---@field bucket BucketConfig?
---@field aw_server AWClientConfig?
local default = {
    bucket = {
        hostname = nil, -- by default value of HOSTNAME env variable
        name = nil, -- by default "aw-watcher-neovim_" .. hostname
    },
    aw_server = {
        host = "127.0.0.1",
        port = 5600,
        ssl_enable = false,
        pulsetime = 30,
    },
}

local function new(opts)
    local config = {}

    config.bucket = opts.bucket or default.bucket
    assert(type(config.bucket) == "table", "bucket config must be a table")

    config.bucket.hostname = config.bucket.hostname or os.getenv("HOSTNAME")
    assert(type(config.bucket.hostname) == "string", "bucket hostname must be a string")

    config.bucket.name = config.bucket.name or ("aw-watcher-neovim_" .. config.bucket.hostname)
    assert(type(config.bucket.name) == "string", "bucket name must be a string")

    config.aw_server = opts.aw_server or default.aw_server
    assert(type(config.aw_server) == "table", "aw server config must be a table")

    config.aw_server.host = config.aw_server.host or default.aw_server.host
    assert(type(config.aw_server.host) == "string", "aw server host must be a string")

    config.aw_server.port = config.aw_server.port or default.aw_server.port
    assert(type(config.aw_server.port) == "number", "aw server port must be a number")

    config.aw_server.ssl_enable = config.aw_server.ssl_enable or default.aw_server.ssl_enable
    assert(type(config.aw_server.ssl_enable) == "boolean", "aw server ssl_enable must be a boolean")

    config.aw_server.pulsetime = config.aw_server.pulsetime or default.aw_server.pulsetime
    assert(type(config.aw_server.pulsetime) == "number", "aw server pulsetime must be a number")

    return config
end

return {
    new = new,
}
