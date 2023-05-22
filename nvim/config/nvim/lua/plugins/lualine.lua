local M = {}
M.methods = {}

function M.setup()
    -- Setup the status line
    require('lualine').setup {
        options = {
            theme='auto',
            icons_enabled = false,
            section_separators = '',
            component_separators = ''
        }
    }
end

return M