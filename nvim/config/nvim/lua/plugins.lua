-- Automatically install packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print("Installing packer. Please close and reopen Neovim...")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_vim = function()
            return require('packer.util').float({ border = 'single' })
        end
    },
    ensure_dependencies = true, --download all dependencies, even if not explicitly downloaded
    autoremove = true,
})

-- Install your plugins here
packer.startup(function(use)
    -- Have packer manage itself
    use 'wbthomason/packer.nvim' -- Have packer manage itself

    -- Tools
    use "nvim-lua/plenary.nvim"
    use 'nvim-telescope/telescope.nvim'
    use 'roobert/search-replace.nvim'

    -- LSPs and LSP Installs
    use 'neovim/nvim-lspconfig'
    use {
        'williamboman/mason.nvim', -- Handles LSP installs
        run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }
    use 'williamboman/mason-lspconfig.nvim'

    -- LSP tools
    use 'simrat39/rust-tools.nvim'      -- Rust setup package
    use 'p00f/clangd_extensions.nvim'   -- clangd setup package
    use 'folke/trouble.nvim'            -- displays diagnosticks a little nicer
    use 'VonHeikemen/lsp-zero.nvim'     -- common tools/functions for lsp

    -- Completion and suggestions
    use 'hrsh7th/nvim-cmp'                      -- framework
    use 'hrsh7th/cmp-nvim-lsp'                  -- lsp completion
    use 'hrsh7th/cmp-nvim-lua'                  -- custom lua completion (for terminal mode)
    use 'hrsh7th/cmp-nvim-lsp-signature-help'   -- Emphasizes current param when calling functions
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-path'                      -- For filesystem paths
    use 'hrsh7th/cmp-buffer'                    -- For things within the buffer
    use 'L3MON4D3/LuaSnip'                      -- For snippets

    -- Better syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    -- Formatting
    use 'lukoshkin/trailing-whitespace'
    -- TODO 'jose-elias-alvarez/null-ls.nvim'

    -- Workspace Packages
    use { 'ms-jpq/chadtree', run=':CHADdeps' }  -- Show File Tree
    use 'ethanholz/nvim-lastplace'              -- Saves buffer history

    -- UI Packages
    use 'mhinz/vim-startify'                    -- Home screen
    use 'nvim-lualine/lualine.nvim'             -- Status Line
    use 'tanvirtin/monokai.nvim'                -- ColorScheme
    use 'LukasPietzschmann/telescope-tabs'      -- Shows tabs in a telescope window
    use 'willothy/nvim-cokeline'                -- Tab Line

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)

-- Starts up the package manager for (mostly) external packages
require('mason').setup()

