Here is what you probably want to do with bash_profile, bash_login and
bashrc dotfiles:

bashrc is run every time you open a new terminal
bash_profile is run once on login

Except: Macs, where Terminal.app runs a login shell by default for each
new terminal window, and therefore calls bash_profile.

So, for debian, you want to put all the normal stuff in the bashrc, and
source that from your bash_profile. Anything you want to run just once,
run from the bash_profile

Probably the best thing to do is to start using zsh instead...
