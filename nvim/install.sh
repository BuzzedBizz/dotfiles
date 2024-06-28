#!/usr/bin/env bash

set -e

mkdir -p $XDG_CONFIG_HOME
ln -sf $DOTFILES/nvim/nvim_config $XDG_CONFIG_HOME/nvim

