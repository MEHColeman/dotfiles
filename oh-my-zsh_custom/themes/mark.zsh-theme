# MEHColeman's Theme
# Mostly based off agnoster's theme - https://gist.github.com/3712874
#
# Removes the powerline font requirement;
# Adds git push/pull icon
#
# Colour a segment, don't work about termination characters, etc
colour_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  echo -n "%{$bg%}%{$fg%}"
  [[ -n $3 ]] && echo -n $3
}

# End the prompt
prompt_end() {
  echo -n "%{%k%}%{%f%}"
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    colour_segment default default "%(!.%{%F{yellow}%}.)$user@%m>"
  fi
}

# here is a handy set of arrows, if your preferences are different to mine
# ← ↑ → ↓ ↔ ↕ ↖ ↗ ↘ ↙ ↯ ⇄ ⇅ ⇆ ⇋ ⇌ ⇔ ⇕ ⇳ ⇵ ⇽ ⇾ ⇿
#
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=$(colour_segment default yellow '↓')
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=$(colour_segment default yellow '↑')
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE=$(colour_segment default red '⇅')

# Git: branch/detached head, dirty status, sync status
prompt_git() {
  local ref dirty
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="$(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      colour_segment black yellow
    else
      colour_segment black green
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:git:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${ref/refs\/heads\//}${vcs_info_msg_0_%% }$(git_remote_status)>"
  fi
}

# Dir: current working directory
prompt_dir() {
  colour_segment black blue '['
  colour_segment black red '%~'
  colour_segment black blue ']>'
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    colour_segment default purple "(`basename $virtualenv_path`)>"
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && colour_segment black default "$symbols"
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_context
  prompt_dir
  prompt_git
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '