export SHELL

source ~/.git-prompt.sh
source ~/.git-completion.bash

PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'

alias ls='ls -p --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'
alias has="curl -sL https://git.io/_has | bash -s"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/soham/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/soham/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/soham/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/soham/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

