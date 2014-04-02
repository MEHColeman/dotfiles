# My configs
clone into .dotfiles directory, run bin/install.rb

## Branches
There is a branch for each environment I need (home mac, work
debian, etc). The master branch contains stuff that is common.  I use .local
files and for stuff useful for only one environment.

Git process: For changes that are useful to all environments, cherry pick from
the topic branch onto master, or write directly onto master.  rebase topic
branches onto master as changes occur.

Currently, the oh-my-zsh directory is independent. It has some custom themes
and plugins that you'll need!

