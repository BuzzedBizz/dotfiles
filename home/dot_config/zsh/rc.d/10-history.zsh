# In ~ rather than the XDG dirs so it servives scratch volume wipes.
zstyle ':zephyr:plugin:history' histfile ~/.zsh_history

# Fallback reverse search; .zshrc rebings ^R to fzf later where fzf exists.
bindkey '^R' history-incremental-search-backward
