# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="mark"
DEFAULT_USER="mark"

# If you want to the command execution time stamp shown
# in the history command output.
export HIST_STAMPS="yyyy-mm-dd"
export HISTSIZE=50000
export SAVEHIST=$HISTSIZE

# Remove duplicate items
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.oh-my-zsh_custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(mark gitfast git-extras tmux dirhistory rbenv thefuck brew docker gem zsh-z zsh-syntax-highlighting kubectl ansible)  #tmuxinator

source $ZSH/oh-my-zsh.sh

# Add paths & configs common to bash and zsh
source $HOME/.shell_profile

# ssh
export SSH_KEY_PATH="$HOME/.ssh/id_ed25519_common"

# init tmuxifier
eval "$(tmuxifier init -)"
export PATH="/usr/local/opt/python@3.9/bin:$PATH"

# init mcfly
eval "$(mcfly init zsh)"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/mark/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
