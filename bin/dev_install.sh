#!/bin/bash

echo "This script installs a full dev environment and tools"
read -p "Are you certain you want to do this? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  mkdir -p ~/dev/bw/projects/
  mkdir -p ~/notes/
  git clone git@github.com:MEHColeman/just_dev_things.git ~/notes/general
  git clone git@github.com:MEHColeman/mehcoleman.github.io.git ~/notes/blog
  cd ~/notes/blog || exit
  git remote add private git@bitbucket.org:MEHColeman/blog.git

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
