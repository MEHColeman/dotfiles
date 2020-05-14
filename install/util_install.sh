#!/bin/bash

echo "This script installs various useful packages on both linux and macOS"

unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)     machine=Linux;;
  Darwin*)    machine=Mac;;
  CYGWIN*)    machine=Cygwin;;
  MINGW*)     machine=MinGw;;
  *)          machine="UNKNOWN:${unameOut}"
esac
echo ${machine}

case $machine in
  Mac)        install_command='brew install';;
  Linux)      install_command='apt-get install -yqq';;
  *)          install_commmand='#'
esac

echo $(install_command)

# both brew and apt-get have the same name
declare -a packages=(
  "ack"
  "bash"
  "cmake"
  "coreutils"
  "dfu-util"
  "elixir"
  "ffmpeg"
  "findutils"
  "gcc"
  "git"
  "grep"
  "hadolint"
  "hub"
  "kubernetes-cli"
  "mosh"
  "par"
  "postgresql"
  "rbenv"
  "reattach-to-user-namespace"
  "shellcheck"
  "thefuck"
  "tig"
  "tmux"
  "tree"
  "vim"
  "youtube-dl"
)

for package in "${packages[@]}"
do
  read -p "Install ${package} ? (y/n) " -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    if [[ $machine = "Mac" ]]
    then
      echo "Installing ${package}"
      eval $install_command $package
    fi
  fi
done

echo "Done"
