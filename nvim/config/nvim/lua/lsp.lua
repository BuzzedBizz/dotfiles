-- Setup LSP autoinstall
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "clangd",
        "cmake",
        "dockerls",
        "docker_compose_language_service",
        "jsonls",
        "pylsp",
        "robotframework_ls",
        "rust_analyzer",
        "lemminx",
        "yamlls"
    },
    automatic_installation = true
})

-- Setup Lsp UI for diagnostics
require("trouble").setup {
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

-- Setup the lsps
require("mason-lspconfig").setup_handlers {
    -- Default Setup For un-specialized lsps
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,

    -- clangd Handler
    ["clangd"] = function ()
        require("clangd_extensions").setup()
    end,

    -- Python Handler
    ["pylsp"] = function ()
        require("lspconfig")['pylsp'].setup({
            plugins = {
                pycodestyle = {
                    maxLineLength = 120
                }
            }
        })
    end,

    -- Rust Handler
    ["rust_analyzer"] = function ()
        require("rust-tools").setup {}
    end,
}
