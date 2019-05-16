#!/bin/sh
if test ! $# -eq 2 ;then
  echo "Usage: $0 PYENV_ROOT PYTHON_VERSION"
else
  export PYENV_ROOT="$1"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  pyenv install $2
fi
