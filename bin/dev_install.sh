#!/bin/bash

echo "This script installs a full dev environment and tools"
read -p "Are you certain you want to do this? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  read -p "Start ssh-agent? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    eval $(ssh-agent)
    ssh-add
  fi

  # Add common projects and dirs
  mkdir -p ~/dev/bw/projects/
  mkdir -p ~/notes/
  git clone git@github.com:MEHColeman/just_dev_things.git ~/notes/general
  git clone git@github.com:MEHColeman/mehcoleman.github.io.git ~/notes/blog
  cd ~/notes/blog || exit
  git remote add private git@bitbucket.org:MEHColeman/blog.git


  # Install and add Vundle plugins
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle
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
