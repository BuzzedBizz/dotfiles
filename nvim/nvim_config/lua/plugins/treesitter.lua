return {
    {
        -- Better syntax highlighting
        'nvim-treesitter/nvim-treesitter',
        build = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        config = function()
            -- todo can we config=true and opts separately
            opts = {
                ensure_installed = {
                    "lua",
                    "rust", "toml",
                    "c", "cpp", "cmake",
                    "dockerfile",
                    "bash",
                    "git_rebase", "gitcommit", "gitignore",
                    "markdown_inline",
                    "python",
                    "vim", "vimdoc",
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                ident = { enable = true },
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = nil,
                }
            }
            require("nvim-treesitter.configs").setup(opts)
        end
    },
}
