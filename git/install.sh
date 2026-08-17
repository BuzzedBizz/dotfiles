#!/usr/bin/env bash

set -e
cp $DOTFILES/git/gitconfig ${XDG_CONFIG_HOME}/.gitconfig
git config --global include.path "$DOTFILES/git/gitconfig_global.symlink"
