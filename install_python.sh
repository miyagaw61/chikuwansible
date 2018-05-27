#!/bin/sh
if test ! $# -eq 2 ;then
  echo "Usage: $0 HOME PYTHON_VERSION"
else
  export PYENV_ROOT=$1/.pyenv
  export PATH=$PYENV_ROOT/bin:$PATH
  eval "$(pyenv init -)"
  pyenv install $2
fi
