vim.api.nvim_create_augroup('bufcheck', { clear = true })

-- start terminal in insert mode
vim.api.nvim_create_autocmd('TermOpen', {
    group    = 'bufcheck',
    pattern  = '*',
    command  = 'startinsert | set winfixheight'
})

-- start terminal without line numbers mode
vim.api.nvim_create_autocmd('TermOpen', {
    group    = 'bufcheck',
    pattern  = '*',
    command  = 'set nonumber norelativenumber'
})

-- Allow ctrl+c in terminal mode
vim.api.nvim_create_autocmd('TermOpen', {
    group    = 'bufcheck',
    pattern  = '*',
    command  = 'nnoremap <buffer> <C-c> i<C-c>'
})

-- start git messages in insert mode
vim.api.nvim_create_autocmd('FileType', {
    group    = 'bufcheck',
    pattern  = { 'gitcommit', 'gitrebase', },
    command  = 'startinsert | 1'
})

-- pager mappings for Manual
vim.api.nvim_create_autocmd('FileType', {
    group    = 'bufcheck',
    pattern  = 'man',
    callback = function()
        vim.keymap.set('n', '<enter>'    , 'K'    , { buffer=true })
        vim.keymap.set('n', '<backspace>', '<c-o>', { buffer=true })
    end
})

-- Alert when we click off the window
vim.api.nvim_create_autocmd('FocusLost', {
    group = 'bufcheck',
    pattern = '*',
    command = 'silent! wa'
})

-- Strip trailing whitespaces on save
vim.api.nvim_create_autocmd('BufWritePre', {
    group = 'bufcheck',
    pattern = "*",
    command = "%s/\\s\\+$//e"
})

