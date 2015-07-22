install chrome
install lastpass/password manager
create .ssh key
add to github
add to bitbucket


# generally useful
sudo apt-get install tmux vim zsh curl cmake git tig

# for rbenv and builder
sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

# for neovim
sudo apt-get install libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

# for vim plugins
sudo apt-get python-dev exuberant-ctags

chsh -s /usr/bin/zsh

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone git@github.com:MEHColeman/dotfiles.git .dotfiles
(updates .zshrc - must happen after!)
ln the .dotfiles/local/rc.<version> into the .dotfiles directory

download and install inconsolata font

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build


mkdir ~/.vim/bundle/
mkdir ~/.vim/_backup
mkdir ~/.vim/_temp
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
vi
> :BundleInstall
> :q

mkdir ~/notes
cd notes
git clone git@github.com:MEHColeman/just_dev_things.git general
git clone git@bitbucket.org:MEHColeman/msp_notes.git msp

