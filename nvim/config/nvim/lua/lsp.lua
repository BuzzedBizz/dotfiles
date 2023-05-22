local use_mason = true

local handlers = {
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

-- Do the setup/installation
if use_mason then
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

    -- Setup the lsps
    require("mason-lspconfig").setup_handlers(handlers)

else
    handlers["clangd"]()
    handlers["pylsp"]()
    handlers["rustanalyzer"]()
end
