# Mark's Dotfiles

This is a repo of my .dotfiles configurations.

I have a number of things to note here:

## Dotfiles
I clone this whole repo into a .dotfile directory, and then link each individual
file or directory back into $HOME/ Some support files are not meant to be
linked, so they are either explicitly skipped in the scripts, or I prefix the
name with NO_DOT

Some configurations are different for my various systems (e.g. work/home or
mac/linux) I have factored out the differences into ```.local``` versions of
files that are then included. For example, I have a ```.aliases``` file. This
will have common aliases that I use all the time, like
~~~
alias sl="ls"
~~~
but also includes the lines
~~~
if [[ -s "$HOME/.aliases.local" ]]
then
  source "$HOME/.aliases.local"
fi
~~~
My local aliases file might then have something like
~~~
alias tac="run some work-related test suite only to be used at company X, internally"
alias open="...some OS specific tool to open a file"
~~~

### Dotfile Installation

To preview what dotfiles are going to get installed, run ```make list_dotfiles```

To install the dotfiles, run 'make dotfiles'. This will link the appropriate
dotfiles to the HOME directory.
To link some common bin files to your $HOME/bin directory, run ```make bin```.
You can run ```make all``` to do both.

Oh!!
You need to specify the target operating system, so runlike this:
~~~
make target_env=generic_ubuntu all
~~~
or
~~~
make target_env=home_macos all
~~~
## Additional Installation Scripts

I've also got here some separate installation scripts that I want to run when I
have a fresh new machine should probably get around to moving a bunch of this
to ansible, but here we are.

These installation scripts install a bunch of packages (e.g. tmux, neofetch...)
that I use all the time. Some packages are OS-dependant, and some are installed
via sh scripts, some brew packages, some debian packages, etc.

I also install an SSH keyfile.

```install/basic_insatll``` installs make and tools to anable further installation scripts to run.
```install/always_install``` installs oh-my-zsh, tmuxifier and updates the dotfile git repo.
```install/mac_install``` and ```install/unix_install``` install useful software that requires diffent installation methods on mac and linux.
```install/dev_install``` installs some useful tools I use during development work.
It also sets up useful working directories that I commonly use when doing
development work.

# Installation on a new machine.

You might not have a bunch of useful tools (like git, or SSH keys..) when you
have a fresh machine, so the recommended installation procedure follows:

You will need curl or wget, sudo and git (for installing homebrew) already installed.

Download the basic installation script from the Github repo:
~~~
curl https://raw.githubusercontent.com/MEHColeman/dotfiles/master/install/basic_install > basic_install
chmod +x basic_install
./basic_install
~~~
useful in order to continue install further software and install the dotfiles.
You need to sudo this script if you're on unix.

Create an .ssh key pair
~~~
curl https://raw.githubusercontent.com/mihaliak/ssh-manager/master/ssh-manager > ssh-manager
~~~
is a nice script to do this on a mac.
Otherwise,
~~~
mkdir -p $HOME/.ssh
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519_unixboxname -C "mark@unixboxname"
~~~

Add this to other machines you need ssh access to, like github, bitbucket, or
another development machine.
For github, copy the public key, and add at ```https://github.com/settings/keys```
Or, `gh auth login`

For other hosts:
~~~
ssh-copy-id -i $HOME/.ssh/id_ed25519_unixboxname username@machine.address
~~~

Next, clone the full repo into the .dotfile directory
~~~
gh repo clone MEHColeman/dotfiles $HOME/.dotfiles
cd $HOME/.dotfiles
~~~

Run the ```install/mac_install``` or ```install/unix_install```
script. These contain packages that are named differently, or have different
installation methods on mac or linux environments.

For a HOME mac, also run the ```install/personal_mac_install``` script to install
things like VLC, plex, mimestream, dropbox, etc.
For a HOME unix box, you can run `install/personal_unix_install`.

Run ```install/util_install``. This contains runs for both mac and linux and
installs useful packages like tig and glances, etc.

```ln -s``` the appropriate local/* files into the .dotfile directory
e.g.
~~~
ln -s local/gitconfig.local.imac_home gitconfig.local
~~~

Touch the files
~~~
shell_profile.private
bash_profile.private
~~~
You can use these later for stuff that shouldn't ever be in a git repo.

`install/always_install` will install oh-my-zsh, tmuxifier and update dotfile
submodules and oh-my-zsh extensions

Now, finally, you can install the dofiles. (See above)
Note that some .directories and .files (like .config) might have already been
created in your $HOME directory during the installation process, so before you
run the make command, you should delete them so that your .dotfiles version can
replace it.

Also,
`[sudo] install/dev_install` will install and configure vim and plugins and
rbenv on both mac and linux

## New installation additional checklist

1. Install your web browser of choice.
2. Install lastpass.

### Mac Manual Installs
Some mac software is unavailable in homebrew or best installed via the app store.
This includes:
- 1Password
- App Cleaner
- Be Focused Pro
- Docker
- Drobo Dashboard
- Evernote
- Honeygain
- Just Press Record
- NeatDownloadManager
- Neon
- Paprika
- Ring
- Things
- Tinkertool
- uBlock

### for rbenv and builder
sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

### for neovim
sudo apt-get install libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

### for vim plugins
sudo apt-get python-dev exuberant-ctags

mkdir ~/.vim/bundle/
mkdir ~/.vim/_backup
mkdir ~/.vim/_temp

# Testing

A ```Makefile``` and ```Dockerfile``` exist in this directory to help create a
little script testing environment.

Use `make docker` to create a test docker image called `docker_dotfile_test`

This will create a test container that will have the `make all`
installation script run on it with a target of `generic_ubuntu`

Opening a shell with
~~~
docker container run -it --rm -v '/Users/mark/.ssh:/home/tester/.ssh' docker_dotfile_test
~~~
will run the container with local ssh keys available (so that git works)

Once running, run `make list_dotfiles` to check what files will be deleted and
replaced by a symlink.

Currently, the oh-my-zsh directory is independent. It has some custom themes
and plugins that you'll need!


## See Also
BASH_PROFILE_NOTES_README.txt
