-- Initialize all the sub files used for configurations

-- Useful global variable
if vim.env.VSCODE then
    vim.g.vscode = true
end

-- using python3.9, this can be upgraded to something higher
-- with the proper prerequisites
vim.g.python3_host_prog = vim.fn.exepath('python3.9')

-- All setup is in the core module
require("core")

