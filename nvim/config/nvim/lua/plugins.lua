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

-- See this for an example structure 
--  https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/bootstrap.lua

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
    use {
        'folke/trouble.nvim',           -- displays diagnosticks a little nicer
        config = function() 
            require("plugins.trouble").setup()
        end
    }
    use 'VonHeikemen/lsp-zero.nvim'     -- common tools/functions for lsp

    -- Completion and suggestions
    use {
        'hrsh7th/nvim-cmp',                     -- framework
        config = function() 
            require("plugins.nvim-cmp").setup()
        end
    }
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
        config = function() 
            require("plugins.nvim-treesitter").setup()
        end
    }

    -- Formatting
    use 'lukoshkin/trailing-whitespace'
    -- TODO 'jose-elias-alvarez/null-ls.nvim'

    -- Workspace Packages
    use {
        'ms-jpq/chadtree',                      -- Show File Tree
        run=':CHADdeps',
        config = function() 
            require("plugins.chadtree").setup()
        end
    }
    use {
        'ethanholz/nvim-lastplace',             -- Saves buffer history
        config = function() 
            require("plugins.nvim-lastplace").setup()
        end
    }

    -- UI Packages
    use 'mhinz/vim-startify'                    -- Home screen
    use {
        'nvim-lualine/lualine.nvim',            -- Status Line
        config = function() 
            require("plugins.lualine").setup()
        end
    }
    use {
        'tanvirtin/monokai.nvim',               -- ColorScheme
        config = function()
            require("plugins.monokai").setup()
        end
    }
    use 'LukasPietzschmann/telescope-tabs'      -- Shows tabs in a telescope window
    -- look into https://github.com/tiagovla/scope.nvim
    -- maybe use https://www.reddit.com/r/neovim/comments/11itoab/how_do_you_manage_tabs_and_split_panes_in_vim/
    use {
        'willothy/nvim-cokeline',               -- Tab Line
        config = function() 
            require("plugins.cokeline").setup()
        end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)

-- Starts up the package manager for (mostly) external packages
require('mason').setup()

