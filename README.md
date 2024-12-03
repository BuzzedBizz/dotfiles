# Houses all my dotfiles and configuration items

Inspired by https://github.com/holman/dotfiles/tree/master

## Installation

Prerequisites:

1. Install a terminal emulator and nerdfont

Install:

1. Run `install/install_dpkgs.sh`
1. Run `install/install_dotfiles.sh`
1. Run `chsh -s $(which zsh)` to make zsh the default

## Troubleshooting

Have problems? First try install a newer version of neovim. You can try:

```sh
sudo -E add-apt-repository ppa:neovim-ppa/unstable
sudo -E apt-get update
sudo -E apt-get install neovim
```
