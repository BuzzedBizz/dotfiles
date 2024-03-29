return {
    -- TODO should I do this or use mason
    { 'simrat39/rust-tools.nvim' },      -- Rust setup package
    { 'p00f/clangd_extensions.nvim' },   -- clangd setup package

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            -- Completetion Sources
            {'hrsh7th/cmp-nvim-lsp'},               -- LSP completion
            {'hrsh7th/cmp-nvim-lua'},               -- Custom lua for terminal mode
            {'hrsh7th/cmp-buffer'},                 -- For things in the current buf
            {'hrsh7th/cmp-path'},                   -- For filesystem paths
            {'hrsh7th/cmp-cmdline' },               -- terminal mode completion
            {'saadparwaiz1/cmp_luasnip'},           -- completion for LuaSnip
            {'hrsh7th/cmp-nvim-lsp-signature-help'},-- Emphasizes current param when calling functions

            -- Snippets engine
            {'L3MON4D3/LuaSnip'},
        },
        config = function()
            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local luasnip = require('luasnip')

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
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false
                    }),

                    -- Iterate through suggestions
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
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
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
        },
        config = function()
            lsp.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp.default_keymaps({buffer = bufnr})
            end)

            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

            -- Do setup for our language servers
            local handlers = {
                -- Default Setup For un-specialized lsps
                function (server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,

                -- clangd Handler
                ["clangd"] = function ()
                    require("clangd_extensions").setup()
                end,

                -- Python Handler
                ["pylsp"] = function ()
                    require("lspconfig")['pylsp'].setup({
                        plugins = {
                            pycodestyle = {
                                maxLineLength = 120
                            }
                        }
                    })
                end,

                -- Rust Handler
                ["rust_analyzer"] = function ()
                    require("rust-tools").setup {}
                end,
            }

            -- Do the setup/installation
            handlers["clangd"]()
            handlers["pylsp"]()
            handlers["rustanalyzer"]()
        end
    },
}
