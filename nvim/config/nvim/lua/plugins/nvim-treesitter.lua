local M = {}
M.methods = {}

function M.setup()
    -------- Setup syntax highlighting
    require("nvim-treesitter.install").prefer_git = true
    require('nvim-treesitter.configs').setup {
        ensure_installed = {
            "lua",
            "rust", "toml",
            "cpp", "cmake",
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
end

return M