return {
    {
        "m4xshen/hardtime.nvim",
        event = "VeryLazy",
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
    {
        -- `opts = {}` is load-bearing: the plugin has no plugin/ directory so
        -- every SearchReplace* command is created inside setup()
        'roobert/search-replace.nvim',
        opts = {},
        cmd = {
            "SearchReplaceSingleBufferVisualSelection",
            "SearchReplaceWithinVisualSelection",
            "SearchReplaceWithinVisualSelectionCWord",
            "SearchReplaceSingleBufferSelections",
            "SearchReplaceSingleBufferOpen",
            "SearchReplaceSingleBufferCWord",
            "SearchReplaceSingleBufferCWORD",
            "SearchReplaceSingleBufferCExpr",
            "SearchReplaceSingleBufferCFile",
            "SearchReplaceMultiBufferSelections",
            "SearchReplaceMultiBufferOpen",
            "SearchReplaceMultiBufferCWord",
            "SearchReplaceMultiBufferCWORD",
            "SearchReplaceMultiBufferCExpr",
            "SearchReplaceMultiBufferCFile",
        },
    },

    {
        'ethanholz/nvim-lastplace', -- reopen buffers at their last location
        opts = {
            lastplace_ignore_buftype = {"quickfix", "nofile", "help" },
            lastplace_ignore_filetype = { "gitcommit", "gitrebase" },
            lastplace_open_folds = true
        }
    },

    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = false,
            highlight = {
                pattern = [[.*<(KEYWORDS)\s*]]
            }
        }
    },
}
