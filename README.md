# Mark's Dotfiles

## Testing
`make docker` to create a test docker image called `docker_dotfile_test`
`docker container run -it --rm -v '/Users/mark/.ssh:/home/tester/.ssh' docker_dotfile_test`
will run the container with local ssh keys available (so that git works)

`make list_dotfiles` to check what files will be deleted and replaced by a symlink.

Currently, the oh-my-zsh directory is independent. It has some custom themes
and plugins that you'll need!

## Installation

Installation will:
* delete existing .dotfiles and replace with symlink from this repository
* install a local bin directory with common useful scripts and executables
* install oh-my-zsh and set zsh to the be default shell.

`git clone` this repository to `.dofiles` directory.
`make all target_env=home_macos` to install the dotfiles with os-specific local files
Valid options are currently home_macos and generic_ubuntu

`install/clean_install.sh` will install oh-my-zsh, tmuxifier and update dotfile
submodules and oh-my-zsh extensions

`install/dev_install.sh` will install and configure vim and plugins and rbenv
`install/util_install.sh` will install a bunch of other useful tools.
