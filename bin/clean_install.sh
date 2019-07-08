#!/bin/bash

read -p "Are you certain you want to do this? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash -s -- --unattended
  mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
fi
