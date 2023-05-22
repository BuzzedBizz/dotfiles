-- Initialize all the sub files used for configurations

-- using python3.8, this can be upgraded to something higher
-- with the proper prerequisites
vim.g.python3_host_prog = vim.fn.exepath('python3.8')

-- Load all our plugins
-- This needs to go first as checking if things are loaded is needed in further steps
require("plugins")

-- Load our custom commands, etc.
require("autocommands")
require("keybindings")
require("options")

-- Load the lsp
require("lsp")
