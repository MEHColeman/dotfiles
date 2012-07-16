if [[ -s /etc/bash_completion.d/git ]] ; then source /etc/bash_completion.d/git ; fi
if [[ -s /usr/local/etc/bash_completion.d/git-completion.bash ]] ; then source /usr/local/etc/bash_completion.d/git-completion.bash ; fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

alias less='less -R'
alias ack='ack-grep'
alias lock='xscreensaver-command -lock'
alias be='bundle exec'
export EDITOR="vim"
export GIT_EDITOR="vim"
export GEM_EDITOR="vim"
export _JAVA_AWT_WM_NONREPARENTING=1
export CLICOLOR=1
export PATH=$HOME/.rvm/bin:$SCALA_HOME/bin:home/tim/.cabal/bin:/home/tim/bin:$PATH
if [[ -s "$HOME/.bash_private" ]]
then
  source "$HOME/.bash_private"
fi
if [[ -s "$HOME/.prompt" ]]
then
  source "$HOME/.prompt"
fi
if [[ -s "$HOME/.aliases" ]]
then
  source "$HOME/.aliases"
fi
