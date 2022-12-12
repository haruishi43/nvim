# neovim config

## macOS setup:

```Bash
defaults write -g ApplePressAndHoldEnabled -bool false
```

for iterm2, enable the setting to treat option key as ESC+

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
sudo ln -sfn /opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
```

MIT License
