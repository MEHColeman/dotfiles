#!/bin/bash

echo "This script installs oh-my-zsh, tmuxifier, rbenv, and updates z.sh"
echo "and any other .dotfile git submodules"
read -p "Are you certain you want to do this? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  read -p "Install oh-my-zsh? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash -s -- --unattended
    mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
  fi

  read -p "Install tmuxifier? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
  fi

  read -p "Update .dotfile submodules? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    cd ~/.dotfiles || exit
    git submodule update --init --recursive
  fi
fi
