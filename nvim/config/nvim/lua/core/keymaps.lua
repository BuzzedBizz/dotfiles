-- Setting the global leader to the comma
-- This has a 1 second timeout
-- This is going to be the default start for all my custom bindings
vim.g.mapleader = ','

-- Tab bindings
vim.keymap.set('n', '<leader>tc', ':tabnew<CR>', {})
vim.keymap.set('n', '<leader>tn', ':tabnext<CR>', {})
vim.keymap.set('n', '<leader>tp', ':tabprev<CR>', {})
vim.keymap.set('n', '<leader>tl', ':Telescope telescope-tabs list_tabs<CR>', {})

-- Window bindings
vim.keymap.set('n', '<leader>vs', ':vsplit<CR>', {})
vim.keymap.set('n', '<leader>hs', ':split<CR>', {})

-- Escape will turn terminal into normal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {})

-- Alt+v is now Ctrl-v
vim.keymap.set('n', '<A-v>', '<C-v>', {})

-- Search
-- local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})   -- files
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})    -- within current directory
--                                                             -- could be updated to use grep_string if not available
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})      -- open buffers
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})    -- help

vim.keymap.set('v', '/', function()
    vim.api.nvim_feedkeys('/' .. vim.getVisualSelection(), 'n', true)
end, {})
vim.keymap.set('v', '<C-f>', '/', { remap = true })
vim.keymap.set('n', '<C-f>', '/', {})                       -- search within file

-- Helper Function to get visual mode selection
function vim.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
        return text
    else
        return ''
    end
end

-- Search And Replace
vim.api.nvim_set_keymap("v", "<C-r>", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", {})
vim.api.nvim_set_keymap("v", "<C-s>", "<CMD>SearchReplaceWithinVisualSelection<CR>", {})
vim.api.nvim_set_keymap("v", "<C-b>", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>rW", "<CMD>SearchReplaceSingleBufferCWORD<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>rf", "<CMD>SearchReplaceSingleBufferCFile<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>rbs", "<CMD>SearchReplaceMultiBufferSelections<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>rbo", "<CMD>SearchReplaceMultiBufferOpen<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>rbw", "<CMD>SearchReplaceMultiBufferCWord<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>rbW", "<CMD>SearchReplaceMultiBufferCWORD<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>rbe", "<CMD>SearchReplaceMultiBufferCExpr<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>rbf", "<CMD>SearchReplaceMultiBufferCFile<CR>", {})

-- show the effects of a search / replace in a live preview window
vim.o.inccommand = "split"

-- LSP Keybindings

-- Trouble Keybindings
-- Keeping these as some still work even if no lsp is on
-- vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {})
-- vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {})
-- vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {})
-- vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {})
-- vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {})
-- vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", {})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            vim.api.nvim_buf_set_option(ev.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings.
            local bufopts = { buffer = ev.buf }

            -- Goto mappings
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true }
        end, bufopts)
    end
})

