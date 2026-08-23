return {
    -- Error message handler
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "TroubleToggle" },
        { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "TroubleDocument" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "TroubleLocList" },
        { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "TroubleQuickFix" },
        { "<leader>xn", ":lua require('trouble').next({ jump = true })<cr>", desc = "TroubleNext" },
        { "<leader>xN", ":lua require('trouble').previous({ jump = true })<cr>", desc = "TroublePrevious" },
        {
            "gR",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "Get LSP References"
        },
    },
    opts = {}
}
