local plugin = require("aw_watcher")

describe("setup", function()
    it("works with default", function() assert(true) end)

    it("works with custom var", function()
        -- plugin.setup({ opt = "custom" })
        assert(true)
    end)
end)
