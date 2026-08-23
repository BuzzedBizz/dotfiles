-- Tabs to spaces
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true

-- Autoindent next line
vim.opt.smartindent=true

vim.opt.foldmethod="expr"
vim.opt.foldexpr="v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = true
vim.opt.foldminlines = 6 -- never close a fold shorter than this many lines

vim.opt.list=true
vim.opt.listchars={ eol = '↲', tab = '→ ', trail = '•', precedes = '«', extends = '»', space = '.', nbsp = '␣' }

vim.opt.scrolloff=10

-- Every yank shells out to a clipboard provider, so only set this where one
-- can work. A space with no X display has none.
if vim.env.DISPLAY or vim.env.WAYLAND_DISPLAY or vim.env.WSL_DISTRO_NAME then
    vim.opt.clipboard = "unnamedplus"
end

vim.opt.cursorline=true
vim.opt.number=true

vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }
vim.opt.wildmode={'full', 'list:longest'}
vim.opt.wildignore={
    '.git', 'DS_Store',
    '*.o', '*.a', '*.so', '*.obj', '*.swp', '*.tmp',
    '*.jpg', '*.jpeg', '*.png', '*.gif', '*.bmp', '*.ico'
}

vim.opt.whichwrap = vim.opt.whichwrap:append('<>')

vim.opt.ignorecase=true  -- ignore case when searching
vim.opt.smartcase=true   -- unless something has a capital
vim.opt.inccommand = "split"

-- lazyredraw is deliberately left of: it causes missing redraws and
-- artifacts with plugins that draw floating windows, which is most of these.

-- We have git
vim.opt.backup=false
vim.opt.writebackup=false
vim.opt.swapfile=false

