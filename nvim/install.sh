#!/usr/bin/env bash

set -e

mkdir -p $XDG_CONFIG_HOME
ln -sfT $DOTFILES/nvim/nvim_config $XDG_CONFIG_HOME/nvim

