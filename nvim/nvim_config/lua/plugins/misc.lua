return {
    -- Vim Improvement Packages
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {
        disable_mouse = false,
            disabled_keys = {
                ["<Up>"] = {},
                ["<Down>"] = {},
                ["<Right>"] = {},
                ["<Left>"] = {},
            },
        }
    }, {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    -- Tools
    { 'roobert/search-replace.nvim' },

    -- Workspace Packages
    {
        'ethanholz/nvim-lastplace',             -- Saves buffer history
        opts = {
            lastplace_ignore_buftype = {"quickfix", "nofile", "help" },
            lastplace_ignore_filetype = { "gitcommit", "gitrebase" },
            lastplace_open_folds = true
        }
    },

    -- Better Diff Views
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
        config = true,
        opts = {
            use_icons = true, -- this overrides with the stuff below
            icons = {
                folder_closed = "▶",
                folder_open = "▼",
            },
            signs = {
                fold_closed = "",
                fold_open = ""
            }
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = false,
            highlight = {
                pattern = [[.*<(KEYWORDS)\s*]]
            }
        }
    },

    -- "kevinhwuang91/nvim-ufo", -- for better folding
    -- "ibhagwan/fzf-lua"
}
