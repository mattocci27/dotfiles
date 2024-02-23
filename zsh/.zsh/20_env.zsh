# locale
# without this, tmux does not recognize some fonts
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# default editor
VISUAL=nvim; export VISUAL EDITOR=nvim; export EDITOR

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='nvim'
fi

# for ssh
export DISPLAY=localhost:0.0

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
#  eval "$(pyenv virtualenv-init -)"
fi

# Ruby configuration
if which rbenv >/dev/null 2>&1; then eval "$(rbenv init -)"; fi

# Set RENV_PATHS_CACHE for Linux systems
if [[ "$(uname -s)" == "Linux" ]]; then
  export RENV_PATHS_CACHE="$HOME/renv"
fi

