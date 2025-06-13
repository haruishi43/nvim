# neovim config

## macOS setup:

```Bash
defaults write -g ApplePressAndHoldEnabled -bool false
```

Also, make sure to disable "Select the previous input source ^Space" in the Keyboard > Shortcuts > Input Sources section.

For iterm2, enable the setting to treat option key as ESC+.

## Dependencies

```bash
brew install neovim
brew install luarocks
brew install ripgrep
brew install fzf

# NodeJS
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.37.2/install.sh | zsh
source ~/.zshrc
loadnvm
nvm install node
```


## Install Node

I prefer to use [nvm](https://github.com/nvm-sh/nvm) since the apt `node` could be incompatible.

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# install node v18
nvm install v18
```


## LaTeX Setup (macOS)

```Bash
# install latex
brew install mactex-no-gui
# install pdfviewer
brew install --cask sioyek
# for ltex
brew install openjdk@11
# need to link:
# intel:
sudo ln -sfn /usr/local/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
# m1:
sudo ln -sfn /opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
```

MIT License
