install this dotfile directory
run the mac_installation.sh script
ln -s the appropriate local/* files into the .dotfile directory
e.g.
ln -s local/gitconfig.local.imac_home gitconfig.local

touch the files
shell_profile.private
bash_profile.private

`install/clean_install.sh` will install oh-my-zsh, tmuxifier and update dotfile
submodules and oh-my-zsh extensions
`[sudo] install/dev_install.sh` will install and configure vim and plugins and rbenv
`[sudo] install/util_install.sh` will install a bunch of other useful tools.


:BundleInstall vim

Ensure powerline patched fonts are installed
https://github.com/powerline/fonts
