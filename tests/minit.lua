#!/usr/bin/env -S nvim -l

vim.env.LAZY_STDPATH = ".tests"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

local spec = {
    "LazyVim/starter",
}

local aw_watcher_lazy_spec = require("../lazy")
for _, mod in ipairs(aw_watcher_lazy_spec) do
    table.insert(spec, mod)
end

require("lazy.minit").busted({ spec = spec })
