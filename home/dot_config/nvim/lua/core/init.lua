-- Must be set before lazy.nvim starts, so plugin `keys` specs pick it up.
vim.g.mapleader = ','

require("core.keymaps")
require("core.opts")
require("core.autocmds")
require("core.lazy")
