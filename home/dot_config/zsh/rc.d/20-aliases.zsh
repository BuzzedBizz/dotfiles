# Machine class comes from .isWSL at apply time. Anything depending on runtime
# state keeps a shell-level guard, because that can change without a re-apply

# ========== General ==========
alias noproxy='http_proxy= https_proxy= '
alias reload='source ~/.zshrc'

# ========== Editor ==========
alias vim="nvim"

# ========== tmux ==========
alias tmux="tmux -2u"

