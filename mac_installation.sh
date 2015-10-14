#!/bin/sh
# copied from lapwinglabs,com/blog/hacker-guide-to-setting-up-your-mac

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

binaries=(
  tree
  ack
  git
  hub
  erlang
  elixir
  ctags
  rbenv
  ruby-build
  cmake
  tmux
  reattach-to-user-namespace
  vim
  mosh
  qt
  pyqt
  sip
)

echo "installing binaries..."
brew install ${binaries[@]}

brew cleanup

# Apps
apps=(
  dropbox
  google-chrome
  appcleaner
  vagrant
  iterm2
  virtualbox
  flux
  vlc
  skype
  transmission
  adium
  filezilla
  multidoge
  litecoin
  teensy
  crashplan
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

brew tap caskroom/fonts

fonts=(
  font-m-plus
  font-clear-sans
  font-roboto
  font-inconsolata
)

# install fonts
echo "installing fonts..."
brew cask install ${fonts[@]}

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle

echo "Don't forget to remove the cntl-arrow mac shortcuts so that tmux works nicely"
