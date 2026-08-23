return {
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

    -- Incremental LSP rename with live preview
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        config = true,
    },

    -- Extract to variable / function /file
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

    -- -- Autocompletion
    {
        'saghen/blink.cmp',
        version ='1.*', -- without a version it will not fetch the prebuilt binaries
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "archie-judd/blink-cmp-words",
            "mikavilpas/blink-ripgrep.nvim",
            "Kaiser-Yang/blink-cmp-git",
            "fang2hou/blink-copilot",
            { 'L3MON4D3/LuaSnip', version ="v2.*" },
        },
        opts = {
            cmdline = {
                keymap = {
                    preset = "cmdline",
                    ['<Tab>'] = {
                        function(cmp)
                            if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then return cmp.accept() end
                        end,
                        'show_and_insert',
                        'select_next'
                    },
                    ['<S-Tab>'] = { "select_prev", "fallback" },

                    -- Not select_and_accept: Enter runs the cmdline as typed.
                    ['<CR>'] = { "fallback" },
                    ['<Right>'] = { "select_and_accept", "fallback" },
                    ['<Left>'] = { "cancel", "fallback" },
                    ['<Up>'] = { "select_prev", "fallback" },
                    ['<Down>'] = { "select_next", "fallback" },
                },
                completion = {
                    menu = { auto_show = true },
                    ghost_text = { enabled = true },
                },
            },
            sources = {
                providers = {
                    cmdline = {
                        -- No completion behing `!`: shelling out is slow on WSL
                        enabled = function()
                            return vim.fn.getcmdtype() ~= ':' or not vim.fn.getcmdline():match("^[%%0-9, '<>%-]*!")
                        end,
                    },
                    path = {
                        opts = {
                            -- Suggest paths relative to cwd, not the buffer
                            get_cwd = function(_)
                                return vim.fn.getcwd()
                            end,
                        },
                    },
                    thesaurus = {
                        name = "blink-cmp-words",
                        module = "blink-cmp-words.thesaurus",
                        max_items = 3,
                        min_keyword_length = 4,
                        score_offset = -100,
                    },
                    ripgrep = {
                        name = "RipGrep",
                        module = "blink-ripgrep",
                        async = true,
                        min_keyword_length = 4,
                        score_offset = -200,
                    },
                    git = {
                        module = "blink-cmp-git",
                        name = 'Git',
                        async = true,
                    },
                },
                per_filetype = {
                    text = { "dictionary", "thesaurus", "buffer" },
                    markdown = { "thesaurus", "buffer" },
                    gitcommit = { "dictionary", "thesaurus", "git", "buffer" }
                },
                default = {
                    "lsp",
                    "buffer",
                    -- "ripgrep",
                    "snippets",
                    "path"
                },
            },
            snippets = { preset = 'luasnip' },
            completion = {
                ghost_text = {
                    enabled = true,
                },
                menu = {
                    draw = {
                        columns = {
                            { 'kind_icon' },
                            { 'label', 'label_description', 'source_name', gap = 1 }
                        },
                        components = {
                            source_name = {
                                text = function(ctx)
                                    if ctx.source_id == 'cmdline' then return end
                                    return "[" .. ctx.source_name:sub(1, 4) .. "]"
                                end,
                            }
                        }
                    }
                }
            },
            keymap = {
                -- Not <C-f>: that is mapped to '/' in lua/core/keymaps.lua.
                ['<C-d>'] = { "scroll_documentation_down" },
                ['<C-u>'] = { "scroll_documentation_up" },

                -- Confirmation behaviour
                ['<CR>'] = { "select_and_accept", "fallback" },
                ['<Right>'] = { "select_and_accept", "fallback" },
                ['<Left>'] = { "cancel", "fallback" },

                -- Iterate through suggestions
                ['<Tab>'] = { "select_prev", "fallback" },
                ['<S-Tab>'] = { "select_next", "fallback" },
            },
            opt_extend = { "sources.default" }
        }
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            { 'saghen/blink.cmp' },
        },
        config = function()
            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                    },
                },
            })
            vim.lsp.enable('lua_ls')

            vim.lsp.config('clangd', {
                cmd = {
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
            })
            vim.lsp.enable('clangd')

            -- Python Handler
            vim.lsp.config("pylsp", {
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
            vim.lsp.enable("pylsp")

            vim.lsp.enable("ruff")

            vim.lsp.config("fort_ls", {})
            vim.lsp.enable("fort_ls")

            -- Rust Handler
            vim.lsp.config("rust_analyzer", {
                settings = {
                    ['rust-analyzer'] = {
                        diagnostics = {
                            enable = false;
                        }
                    }
                }
            })
            vim.lsp.enable("rust_analyzer")
        end
    },
}
