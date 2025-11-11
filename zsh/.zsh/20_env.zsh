# locale
# without this, tmux does not recognize some fonts
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export SECOND_BRAIN="$HOME/Documents/Second Brain"

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

# for docker
export HOST_UID=$(id -u)
export HOST_GID=$(id -g)

# Determine environment
OS_NAME=$(uname -s 2>/dev/null || echo unknown)
IS_LINUX_CONTAINER=$([ -f /.dockerenv ] || [ -f /run/.containerenv ] && echo true || echo false)

# Enable proxy if:
#   • Host is Linux (HOST_PLATFORM=linux) AND container is Linux
#   • OR we’re running directly on a Linux host (no container)
if {
     [ "${HOST_PLATFORM}" = "linux" ] && [ "${IS_LINUX_CONTAINER}" = "true" ]
   } || {
     [ "${OS_NAME}" = "Linux" ] && [ -z "${HOST_PLATFORM}" ]
   }; then
  export HTTP_PROXY="${HTTP_PROXY:-http://127.0.0.1:18089}"
  export HTTPS_PROXY="${HTTPS_PROXY:-http://127.0.0.1:18089}"
  export NO_PROXY="${NO_PROXY:-localhost,127.0.0.1,::1}"
fi


