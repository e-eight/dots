export SHELL

source ~/.git-prompt.sh
source ~/.git-completion.bash

PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'

alias ls='ls -p --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'
alias has="curl -sL https://git.io/_has | bash -s"

show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
export -f show_virtual_env
PS1='$(show_virtual_env)'$PS1

eval "$(direnv hook bash)"
