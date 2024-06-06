return {
    {
        -- Look here for some best practices
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = "FindFile" },
            { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = "GrepDirectory" },
            { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = "FindBuff" },
            { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = "FindHelp" },
        }
    },
    {
        'LukasPietzschmann/telescope-tabs',     -- Shows tabs in a telescope window
        keys = {
            { '<leader>tl', ':Telescope telescope-tabs list_tabs<CR>', desc = "TabList" }
        }
    }
}
