#!/bin/bash

echo "This script installs various useful packages on both linux and macOS"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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
  Mac)        install_command="brew install";;
  Linux)      install_command="apt-get install -yqq";;
  *)          install_command="#"
esac

echo $install_command

# both brew and apt-get have the same name
declare -a packages=(
  "ack"
  "alacritty"
  "bash"
  "cmake"
  "coreutils"
  "dfu-util"
  "elixir"
  "ffmpeg"
  "findutils"
  "gcc"
  "git"
  "glances"
  "grep"
  "hadolint"
  "mosh"
  "node"
  "neofetch"
  "neovim"
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
  "yt-dlp"
)

brew install mcfly

if [[ $machine=Linux ]]
then
  apt-get install software-properties-common
  add-apt-repository ppa:aslatter/ppa
fi

for package in "${packages[@]}"

do
  read -p "Install ${package} ? (y/n) " -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo "Installing ${package}"
    eval $install_command $package
  fi
done

echo "Done"
