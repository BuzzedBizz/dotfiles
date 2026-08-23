return {
    {
        "folke/snacks.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            statuscolumn = { enabled = true },
            dashboard = {
                enabled = true,
                width = 80,
                formats = {
                    key = function(item)
                        return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
                    end,
                },
                sections = {
                    { section = "terminal", cmd = "cow-fortune -u -w 76", hl = "header", padding = 1, indent = 0, auto_close = true },
                    { title = "MRU", padding = 1 },
                    { section = "recent_files", limit = 8, padding = 1 },
                    { title = "MRU ", file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
                    { section = "recent_files", cwd = true, limit = 8, padding = 1 },
                    { title = "Sessions", padding = 1, limit = 3 },
                    { section = "projects", padding = 1 },
                    { title = "Bookmarks", padding = 1 },
                    { section = "keys" },
                }
            },
            bigfile = {
                enabled = true
            },
            explorer = {
                enabled = true,
                replace_netrw = true,
                trash = false,
            },
            picker = {
                hidden = true,
                ignored = true,
                enabled = true,
            },
            keys = {
                -- Pickers and Explorers
                { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
                { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
                { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
                { "<leader>ct", function() Snacks.explorer() end, desc = "File Explorer" },
                -- find
                { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
                { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
                { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
                { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
                { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
                -- git
                { "<leader>gB", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
                { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
                { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
                { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
                { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
                { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },
                { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
                -- Grep
                { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
                { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
                { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
                { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection on word" }, mode = { "n", "x" },
            }
        },
    }
}
