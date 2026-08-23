-- mapleader is set in lua/core/init.lua, before lazy.nvim starts.

vim.keymap.set('n', '<leader>tc', ':tabnew<CR>', { desc = 'New tab'})
vim.keymap.set('n', '<leader>tn', ':tabnext<CR>', { desc = 'Next tab'})
vim.keymap.set('n', '<leader>tp', ':tabprev<CR>', { desc = 'Previous tab'})

vim.keymap.set('n', '<leader>vs', ':vsplit<CR>', { desc = 'Split vertically' })
vim.keymap.set('n', '<leader>hs', ':split<CR>', { desc = 'Split horizontally' })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Terminal normal mode' })
vim.keymap.set('n', '<A-v>', '<C-v>', { desc = 'Visual Block' })

-- Yank the visual selection into register v and return it as one line
function visual_selection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})
    return (text:gsub('\n', ''))
end

vim.keymap.set('v', '/', function()
    vim.api.nvim_feedkeys('/' .. visual_selection(), 'n', true)
end, { desc = 'Search for visual selection' })
vim.keymap.set('v', '<C-f>', '/', { remap = true })
vim.keymap.set('n', '<C-f>', '/', { desc = 'Search within file' })

-- search-replace.nvim is lazy loaded on these command names; see
-- lua/plugins/misc.lua.
for _, m in ipairs({
    {"v", "<C-r>",       "SingleBufferVisualSelection" },
    {"v", "<C-s>",       "WithinVisualSelection"       },
    {"v", "<C-b>",       "WithinVisualSelectionCWord"  },
    {"n", "<leader>rs",  "SingleBufferSelections"      },
    {"n", "<leader>ro",  "SingleBufferOpen"            },
    {"n", "<leader>rw",  "SingleBufferCWord"           },
    {"n", "<leader>rW",  "SingleBufferCWORD"           },
    {"n", "<leader>re",  "SingleBufferCExpr"           },
    {"n", "<leader>rf",  "SingleBufferCFile"           },
    {"n", "<leader>rbs", "MultiBufferSelections"       },
    {"n", "<leader>rbo", "MultiBufferOpen"             },
    {"n", "<leader>rbw", "MultiBufferCWord"            },
    {"n", "<leader>rbW", "MultiBufferCWORD"            },
    {"n", "<leader>rbe", "MultiBufferCExpr"            },
    {"n", "<leader>rbf", "MultiBufferCFile"            },
}) do
    local mode, lhs, cmd = m[1], m[2], m[3]
    vim.keymap.set(mode, lhs, '<CMD>SearchReplace' .. cmd .. '<CR>', { desc = 'SearchReplace' .. cmd })
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        local bufopts = { buffer = ev.buf }

        -- goto_prev/goto_next are deprecated in favour of jump(); fall back
        -- where jump() does not exist yet
        local function diag_jump(count)
            return function()
                if vim.diagnostic.jump then
                    vim.diagnostic.jump({ count = count, float = true })
                elseif count < 0 then
                    vim.diagnostic.goto_prev()
                else
                    vim.diagnostic.goto_next()
                end
            end
        end

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '[d', diag_jump(-1), bufopts)
        vim.keymap.set('n', ']d', diag_jump(1), bufopts)

        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format({ async = true })
        end, bufopts)
    end
})

