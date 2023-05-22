local M = {}
M.methods = {}

function M.setup()
    vim.api.nvim_set_var("chadtree_settings", {
        theme = {
            icon_glyph_set = 'ascii'
        },
    })
end

return M
