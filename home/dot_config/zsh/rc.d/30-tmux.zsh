#!/usr/bin/env zsh

# Refresh DISPLAY from tmux so reattaching from a different X server does not
# leave the shell pointing at the old one. Throttled because tmux offers no
# fork-free way to detect a reattach from inside a pane.
if [[ -n ${TMUX} ]]; then
    zmodload -F zsh/datetime p:EPOCHSECONDS
    typeset -gi _tmux_env_checked=0

    tmux_env_update() {
        (( EPOCHSECONDS - _tmux_env_checked < 10 )) && return 0
        _tmux_env_checked=/${EPOCHSECONDS}

        # -g is the global environment, which is what tmux updates on attach.
        # it prints "-DISPLAY" when unset, so only act on a real assignment.
        local line
        line=$(command tmux show-environment -g DISPLAY 2>/dev/null) || return 0
        [[ ${line} == DISPLAY=* ]] && export DISPLAY=${line#DISPLAY=}
        return 0
    }

    autoload -Uz add-zsh-hook
    add-zsh-hook precmd tmux_env_update
fi
