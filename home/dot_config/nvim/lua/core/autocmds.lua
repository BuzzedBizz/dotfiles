-- Cleared on definition so re-sourcing the config does not stack duplicates.
local bufcheck = vim.api.nvim_create_augroup('bufcheck', { clear = true })

-- Recalculate folds on buffer open (preserves comments)
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWinEnter' }, {
    group   = bufcheck,
    pattern = '*',
    command = 'normal! zx'
})

-- Enable lsp-based folding when supported
vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    group   = bufcheck,
    callback = function(args)
        local cliend = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method('textDocument/foldingRange') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end
    end,
})

-- start terminal in insert mode, main window only
vim.api.nvim_create_autocmd('TermOpen', {
    group    = bufcheck,
    pattern  = '*',
    callback = function()
        if vim.bo.buftype == 'terminal' and vim.fn.winnr() == 1 then
            vim.cmd('startinsert | set winfixheight')
        end
    end
})

vim.api.nvim_create_autocmd('TermOpen', {
    group    = bufcheck,
    pattern  = '*',
    command  = 'set nonumber norelativenumber'
})

-- Allow ctrl+c in terminal mode
vim.api.nvim_create_autocmd('TermOpen', {
    group    = bufcheck,
    pattern  = '*',
    command  = 'nnoremap <buffer> <C-c> i<C-c>'
})

-- start git messages in insert mode
vim.api.nvim_create_autocmd('FileType', {
    group    = bufcheck,
    pattern  = { 'gitcommit', 'gitrebase', },
    command  = 'startinsert | 1'
})

-- pager mappings for Manual
vim.api.nvim_create_autocmd('FileType', {
    group    = bufcheck,
    pattern  = 'man',
    callback = function()
        vim.keymap.set('n', '<enter>'    , 'K'    , { buffer=true })
        vim.keymap.set('n', '<backspace>', '<c-o>', { buffer=true })
    end
})

-- Save on focuse loss. `update`, not `wa`: with the whitespace strip below,
-- writing every modified buffer silently rewrote ones still being edited.
vim.api.nvim_create_autocmd('FocusLost', {
    group = bufcheck,
    pattern = '*',
    command = 'silent! update'
})

-- Strip trailing whitespace on save. Skips unmodifiable buffers, which raise
-- E21 - :checkhealth writes one. Restores the view since :s moves the cursor
vim.api.nvim_create_autocmd('BufWritePre', {
    group = bufcheck,
    pattern = "*",
    callback = function()
        if not vim.bo.modifiable or vim.bo.readonly then
            return
        end
        local view = vim.fn.winsaveview()
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.fn.winrestview(view)
    end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    group = bufcheck,
    pattern = '*',
    callback = function()
        -- vim highlight was renamed to vim.hl in nvim.0.11
        local hl = vim.hl or vim.highlight
        hl.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

