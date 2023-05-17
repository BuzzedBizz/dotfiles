-------- Setup completion
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},

        -- Confirmation behaviour
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({select = true}),
        ['<CR>'] = cmp.mapping.confirm({select = false}),

        -- Iterate through suggestions
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'buffer' },
    },
})

-- Terminal completion
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-------- Setup syntax highlighting
require("nvim-treesitter.install").prefer_git = true
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "lua",
        "rust", "toml",
        "cpp", "cmake",
        "dockerfile",
        "bash",
        "git_rebase", "gitcommit", "gitignore",
        "markdown_inline",
        "python",
        "vim", "vimdoc",
    },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    ident = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
}

-------- Setup Workspace Functions
-- Setup File Explorer
vim.api.nvim_set_var("chadtree_settings", {
    theme = {
        icon_glyph_set = 'ascii'
    },
})

-- Setup position saving
require('nvim-lastplace').setup({
    lastplace_ignore_buftype = {"quickfix", "nofile", "help" },
    lastplace_ignore_filetype = { "gitcommit", "gitrebase" },
    lastplace_open_folds = true
})

-------- Setup UI
-- Setup colorscheme
require('monokai').setup({
    palette = require('monokai').pro
})

-- Setup the status line
require('lualine').setup {
    options = {
        theme='auto',
        icons_enabled = false,
        section_separators = '',
        component_separators = ''
    }
}

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
