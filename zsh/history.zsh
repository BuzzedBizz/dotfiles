# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt extended_history         # record timestamp of command in HISTFILE
setopt hist_expire_dups_first   # delete duplicates first when HISTFILE exceeds HISTSIZE
setopt hist_ignore_dups         # ignore duplicated commands history list
setopt hist_ignore_space        # ignore commands that start with a space
setopt hist_verify              # show command with history expansion to user before running it
setopt inc_append_history       # add commands to HISTFILE in order of execution
setopt share_history            # shared command history data

bindkey "^R" history-incremental-pattern-search-backward

