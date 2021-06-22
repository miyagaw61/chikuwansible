#pyenv
#ANSIBLE_PYENVexport PYENV_ROOT={{pyenv_root}}
#ANSIBLE_PYENVexport PATH=$PYENV_ROOT/bin:$PATH
#ANSIBLE_PYENVeval "$(pyenv init -)"
#ANSIBLE_PYENVeval "$(pyenv init --path)"
#ANSIBLE_PYENVif command -v pyenv 1>/dev/null 2>&1; then
#ANSIBLE_PYENV    eval "$(pyenv init -)"
#ANSIBLE_PYENVfi
