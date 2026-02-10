# set PIPENV behaviour to always place .venv inside the project
export PIPENV_VENV_IN_PROJECT=true

if [ `uname` = "Darwin" ]; then
  # set op homebrew
  if [ -e /opt/homebrew ]; then
    HOMEBREW_ROOT=/opt/homebrew
  else
    HOMEBREW_ROOT=/usr/local
  fi
  export HOMEBREW_ROOT

  eval $(${HOMEBREW_ROOT}/bin/brew shellenv)

  # set up pyenv
  #export PYENV_ROOT=${HOMEBREW_ROOT}/var/pyenv
  export PYENV_ROOT="$HOME/.pyenv"
  if command -v pyenv 1>/dev/null 2>&1; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
  fi

fi

# Added by `rbenv init` on Fri Nov 22 17:40:10 CST 2024
eval "$(rbenv init - --no-rehash zsh)"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
