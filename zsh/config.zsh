#!/usr/bin/env zsh
# TODO Do I want to use oh-my-zsh instead?

unsetopt BEEP
setopt auto_cd # cd by typing diroctory name if it's not a command
setopt cdable_vars # we'll switch env to $env when using cd

# Languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Paths, if not set
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=~/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:=~/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:=~/.local/state}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:=~/.local/cache}

# Autocomplete
setopt correct_all # autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

zstyle ':completion:*' menu select # select completions with arrow keys

# Colours
if [ -x /usr/bin/dircolors ]; then
    if [ -r ~/.dircolors ]; then
        eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

