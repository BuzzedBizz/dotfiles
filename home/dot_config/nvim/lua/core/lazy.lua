-- lazy.nvim is cloned by .chezmoiscripts/run_onchange_after20-plugin-managers.sh.
-- Depgrade to a plugin-less nvim rather than failing to start.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.apy.nvim_echo({
        { "lazy.nvim is not installed at " .. lazypath .. "\n", "ErrorMsg" },
        { "Run `chezmoi apply` to clone it. Continuing without plugins.\n", "WarningMsg" },
    }, true, {})
    return
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    ui = {
        icons = {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
})

