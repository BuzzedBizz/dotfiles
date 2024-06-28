return {
    {
        -- Home Screen
        'mhinz/vim-startify',
        -- TODO this isn't detecting the filetype on initial startup, so we have no colours
    },
    {
        -- ColourScheme
        "tanvirtin/monokai.nvim",
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
        },
        sections = {
            lualine_x = { "aerial", "encoding", "fileformat", "filetype" }
        }
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
        }
    },
    {
        -- Tab Line
        "willothy/nvim-cokeline",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            local get_hl_attr = require('cokeline/hlgroups').get_hl_attr
            require('cokeline').setup {
                show_if_buffers_are_at_least = 0,
                default_hl = {
                    fg = function(buffer)
                    return
                        buffer.is_focused
                        and get_hl_attr('StatusLine', 'bg')
                        or get_hl_attr('StatusLine', 'fg')
                    end,
                    bg = function(buffer)
                    return
                        buffer.is_focused
                        and get_hl_attr('StatusLine', 'fg')
                        or get_hl_attr('StatusLine', 'bg')
                    end,
                },
                sidebar = {
                    filetype = 'NvimTree',
                    components = {
                        {
                            text = '  NvimTree',
                            fg = yellow,
                            bg = get_hl_attr('NvimTreeNormal', 'bg'),
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
                        fg = get_hl_attr('Comment', 'fg'),
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
