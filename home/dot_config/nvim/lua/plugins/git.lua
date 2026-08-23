return {
    {
        "folke/snacks.nvim",
        opts = {
            git = { enabled = true },
            gitbrowse = { enabled = true },
        },
        keys = {
            { "<leader>gb", function () Snacks.git.blame_line() end, desc = "Git Blame current line" },
        }
    },
    -- Add/remove/modified markers in the sign column
    {
        "lewis6991/gitsigns.nvim",
        opts = {}
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
        opts = {
            use_icons = true,
            icons = {
                folder_closed = "▶",
                folder_open = "▼",
            },
            sign = {
                fold_closed = "",
                fold_open = ""
            },
            view = {
                merge_tool = {
                    layout = "diff3_mixed"
                }
            }
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    }
}
