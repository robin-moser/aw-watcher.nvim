local plugin = require("aw_watcher")

vim.api.nvim_create_user_command(
    "Heartbeat",
    function() plugin.heartbeat() end,
    { bang = true, desc = "send a heartbeat" }
)
vim.api.nvim_create_user_command(
    "AWStart",
    function() plugin.bucket_start() end,
    { bang = true, desc = "start activity watcher" }
)
vim.api.nvim_create_user_command(
    "AWStatus",
    function() plugin.connect_status() end,
    { bang = true, desc = "currently connected status" }
)
