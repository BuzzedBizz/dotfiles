-- Setting the global leader to the comma
-- This has a 1 second timeout
-- This is going to be the default start for all my custom bindings
-- This is needed here before lazy is started
vim.g.mapleader = ','

-- Start up the plugin manager
require("core.lazy")({
    debug = false,
    defaults = {
        -- lazy = true,
        -- cond = false,
    },
    performance = {
        cache = {
            enabled = true,
        },
    },
})

require("core.keymaps")
require("core.opts")
require("core.autocmds")
