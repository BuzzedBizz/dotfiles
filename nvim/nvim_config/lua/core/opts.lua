-- Tabs to spaces
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true

-- Autoindent next line
vim.opt.smartindent=true

-- Set up code folding
vim.opt.foldmethod="expr"
vim.opt.foldexpr="nvim_treesitter#foldexpr()"

-- Making Invisible Characters visible
vim.opt.list=true
vim.opt.listchars={ eol = '↲', tab = '→ ', trail = '•', precedes = '«', extends = '»', space = '.', nbsp = '␣' }

-- Let 10 lines exist before/after the cursor
vim.opt.scrolloff=10

-- Set up the clipboard so we can use the system clipboard
vim.opt.clipboard="unnamedplus"

-- Highlight current line
vim.opt.cursorline=true

-- Show line numbers
vim.opt.number=true

-- Show vim command autocomplete menup
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }
vim.opt.wildmode={'full', 'list:longest'}
vim.opt.wildignore={
    '.git', 'DS_Store',
    '*.o', '*.a', '*.so', '*.obj', '*.swp', '*.tmp',
    '*.jpg', '*.jpeg', '*.png', '*.gif', '*.bmp', '*.ico'
}
vim.opt.foldminlines = 6 -- only fold if there are less than these lines

-- Wrap cursor across lines
vim.opt.whichwrap = vim.opt.whichwrap:append('<>')

-- Searching
vim.opt.ignorecase=true  -- ignore case when searching
vim.opt.smartcase=true   -- unless something has a capital

-- Don't redraw while executing macros
vim.opt.lazyredraw=true

-- Turn backup off, since we do git anyways
vim.opt.backup=false
vim.opt.wb=false
vim.opt.swapfile=false

