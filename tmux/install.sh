#!/usr/bin/env bash

set -e

mkdir -p $XDG_CONFIG_HOME
ln -sfT $DOTFILES/tmux/tmux_config $XDG_CONFIG_HOME/tmux

