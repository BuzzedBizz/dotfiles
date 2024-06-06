return {
    -- Error message handler
    "folke/trouble.nvim",
    keys = {
        { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "TroubleToggle" },
        { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "TroubleWorkspace" },
        { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "TroubleDocument" },
        { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "TroubleLocal" },
        { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "TroubleQuickFix" },
        { "gR", "<cmd>TroubleToggle lsp_references<cr>", desc = "GetReferences" },
    },
    opts = {
        icons = false,
        fold_open = "v", -- icon used for open folds
        fold_closed = ">", -- icon used for closed folds
        indent_lines = false, -- add an indent guide below the fold icons
        signs = {
            -- icons / text used for a diagnostic
            error = "E",
            warning = "W",
            hint = "H",
            information = "I"
        },
        use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    }
}
