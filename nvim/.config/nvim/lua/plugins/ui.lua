return {
    {
        -- Home Screen
        'mhinz/vim-startify'
    },
    {
        "tanvirtin/monokai.nvim", -- ColourScheme
        init = function()
            require("monokai").setup({
                palette = require("monokai").ristretto
            })
        end
    },
    {
        -- Status Line
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme='auto',
                icons_enabled = false,
                section_separators = '',
                component_separators = ''
            }
        }
    },
    {
        -- Tab Line
        "willothy/nvim-cokeline",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local get_hex = require('cokeline/utils').get_hex
            require('cokeline').setup {
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
                sidebar = {
                    filetype = 'NvimTree',
                    components = {
                        {
                            text = '  NvimTree',
                            fg = yellow,
                            bg = get_hex('NvimTreeNormal', 'bg'),
                            style = 'bold',
                        },
                    }
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
            }
        end
    },
}
