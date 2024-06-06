return {
    -- TODO should I do this or use mason
    { 'simrat39/rust-tools.nvim' },      -- Rust setup package
    { 'p00f/clangd_extensions.nvim' },   -- clangd setup package

    -- Document Generator
    {
        "danymat/neogen",
        opts = { snippet_engine = "luasnip" },
        keys = {
            {
                "<leader>cc",
                function()
                    require("neogen").generate({})
                end,
                desc = "Neogen Comment",
            },
        },
        cmd = "Neogen",
        requires = "nvim-treesitter/nvim-treesitter",
    },

    -- Allows renaming of things
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        config = true,
    },

    -- ALlows extraction of stuff (e.g. to another file)
    -- TODO we can use telescope for this
    {
        "ThePrimeagen/refactoring.nvim",
        keys = {
            {
                "<leader>r",
                function()
                    require("refactoring").select_refactor()
                end,
                mode = "v",
                noremap = true,
                silent = true,
                expr = false,
            }
        },
        opts = {},
    },

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
        lazy = false,
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
            -- require('lspconfig').lua_ls.setup(vim.lsp.nvim_lua_ls())
            lspconfig = require('lspconfig')

            -- Do the setup/installation
            lspconfig['clangd'].setup({
                on_attach = function(client, bufnr)
                    -- do_on_attach_fns(client, bufnr, true)
                    require('clangd_extensions.inlay_hints').setup_autocmd()
                    require('clangd_extensions.inlay_hints').set_inlay_hints()
                end,
                cmd = {
                    -- TODO Finish this
                    'clangd',
                    -- '--background-index',
                    -- '--clang-tidy',
                    '--completion-style=bundled',
                    -- '--cross-file-rename',
                    '--all-scopes-completion',
                    -- '--log=error',
                    '--suggest-missing-includes',
                    '--pch-storage=memory',
                },
                init_options = {
                    clangdFileStatus = true,
                    usePlaceholders = true,
                    completeUnimported = true,
                    semanticHighlighting = true,
                },
                capabilities = client_capabilities,
            })

            -- Python Handler
            lspconfig["pylsp"].setup({
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                ignore = {'W391'},
                                maxLineLength = 120
                            }
                        }
                    }
                }
            })

            -- Rust Handler
            lspconfig["rust_analyzer"] = function ()
                require("rust-tools").setup({})
            end
        end
    },
}
