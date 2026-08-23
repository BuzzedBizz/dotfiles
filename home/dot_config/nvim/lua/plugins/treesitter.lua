return {
    {
        'romus204/tree-sitter-manager.nvim',
        dependencies = {}, -- tree-sitter CLI must be installed system-wide
        config = function()
            require("tree-sitter-manager").setup({
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
            })
        end,
    }
}
