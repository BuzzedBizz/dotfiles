#!/usr/bin/env bash

set -e

mkdir -p $XDG_CONFIG_HOME
ln -sfT $DOTFILES/tig/tig_config $XDG_CONFIG_HOME/tig

