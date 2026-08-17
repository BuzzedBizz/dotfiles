# Putting this in ~ instead of the XDG dirs so
# that it will never be lost on tmpdir wipes
zstyle ':zephyr:plugin:history' histfile ~/.zsh_history
bindkey '^R' history-incremental-search-backward
