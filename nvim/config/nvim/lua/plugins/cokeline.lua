local M = {}
M.methods = {}

function M.setup()
    -- Setup the tab line
    local get_hex = require('cokeline/utils').get_hex
    require('cokeline').setup({
        default_hl = {
            fg = function(buffer)
            return
                buffer.is_focused
                and get_hex('StatusLine', 'bg')
                or get_hex('StatusLine', 'fg')
            end,
            bg = function(buffer)
            return
                buffer.is_focused
                and get_hex('StatusLine', 'fg')
                or get_hex('StatusLine', 'bg')
            end,
        },
        components = {
            {
                text = function(buffer) return (buffer.index ~= 1) and '▏ ' or '  ' end,
            },
            {
                text = function(buffer) return buffer.unique_prefix end,
                fg = get_hex('Comment', 'fg'),
                style = 'italic',
            },
            {
                text = function(buffer) return buffer.filename .. ' ' end,
            },
            {
                text = function(buffer)
                    return buffer.is_modified and '●' or '×'
                end,
                delete_buffer_on_left_click = true,
            },
            {
                text = ' ',
            }
        },
    })
end

return M