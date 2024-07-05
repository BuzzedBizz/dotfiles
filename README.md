# Houses all my dotfiles and configuration items

Inspired by https://github.com/holman/dotfiles/tree/master

## How to use

1. Run `chsh -s $(which zsh)` to make zsh the default
2. Install/Use a nerdfont in your terminal window
3. Run `install/bootstrap.sh`
4. Run `install/install_dotfiles.sh`

If you are running an old version of neovim, try:

```sh
sudo -E add-apt-repository ppa:neovim-ppa/unstable
sudo -E apt-get update
sudo -E apt-get install neovim
```

