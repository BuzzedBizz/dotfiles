return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        keys = {
            { "<leader>ct", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
        },
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            require("nvim-tree").setup({
                actions = {
                    change_dir = {
                        global = true
                    }
                },
                renderer = {
                    icons = {
                        show = {
                            git = false,
                            modified = true,
                        },
                        glyphs = {
                            default = "●",
                            symlink = "",
                            bookmark = "",
                            modified = "○",
                            folder = {
                                arrow_closed = " ",
                                arrow_open = " ",
                                default = "▶",
                                open = "▼",
                                empty = "▶",
                                empty_open = "▼",
                                symlink = "-▶",
                                symlink_open = "-▼"
                            }
                        },
                    }
                }
            })
        end,
    }
}
