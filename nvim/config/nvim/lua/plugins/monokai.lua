local M = {}
M.methods = {}

function M.setup()

-------- Setup UI
-- Setup colorscheme
require('monokai').setup({
    palette = require('monokai').pro
})
end

return M