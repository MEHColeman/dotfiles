#!/bin/bash

echo "This script installs a full dev environment and tools"
read -p "Are you certain you want to do this? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  vim +BundleInstall +qall
  cd ~/.vim/bundle/YouCompleteMe || exit
  ./install.py --all

  read -p "Install rbenv? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
  fi
fi
