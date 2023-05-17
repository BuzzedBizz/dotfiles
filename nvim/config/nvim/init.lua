-- Initialize all the sub files used for configurations

-- using python3.8, this can be upgraded to something higher
-- with the proper prerequisites
vim.g.python3_host_prog = vim.fn.exepath('python3.8')

require("autocommands")
require("keybindings")
require("options")
require("plugins")
require("plugin_config")
require("lsp")

