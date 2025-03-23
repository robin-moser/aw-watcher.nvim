local aw_watcher = require("aw_watcher")

return {
    check = function()
        vim.health.start("AW Watcher Report")

        local aw = aw_watcher.__private.aw
        local cfg = aw_watcher.__private.cached_cfg

        if not aw then
            vim.health.error("AW Client haven't been initialized yet.")
            return
        end

        if not aw.connected then
            vim.health.error("AW Client have been initialized, but not connected to the server yet.")
            return
        end

        vim.health.ok(
            ("Setup is correct. AW Client connected to the server %s:%s."):format(
                cfg.aw_server.host,
                cfg.aw_server.port
            )
        )
    end,
}
