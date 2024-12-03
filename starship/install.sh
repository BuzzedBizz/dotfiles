#!/usr/bin/env bash

set -e

mkdir -p $XDG_CONFIG_HOME
ln -sfT $DOTFILES/starship/starship_config $XDG_CONFIG_HOME/starship
