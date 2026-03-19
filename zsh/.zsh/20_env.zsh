# OS helpers (available to all files loaded after this one)
is_mac()   { [[ "$(uname -s)" == "Darwin" ]]; }
is_linux() { [[ "$(uname -s)" == "Linux"  ]]; }

# locale
# without this, tmux does not recognize some fonts
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export SECOND_BRAIN="$HOME/Documents/Second Brain"

# default editor
export VISUAL='nvim'
export EDITOR='nvim'

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
if is_linux; then
  export RENV_PATHS_CACHE="$HOME/.cache/R/renv"
fi

# for docker
export HOST_UID=$(id -u)
export HOST_GID=$(id -g)

# Determine environment
OS_NAME=$(uname -s 2>/dev/null || echo unknown)
IS_LINUX_CONTAINER=$([ -f /.dockerenv ] || [ -f /run/.containerenv ] && echo true || echo false)


# Enable proxy if:
#   • Hostname is "big-nose" (only this machine should use proxy)
#   • AND:
#       - Host is Linux (HOST_PLATFORM=linux) AND container is Linux
#       - OR running directly on a Linux host (no container)
HOSTNAME_SHORT=$(hostname -s)

if [ "${HOSTNAME_SHORT}" = "big-nose" ] && {
  { [ "${HOST_PLATFORM}" = "linux" ] && [ "${IS_LINUX_CONTAINER}" = "true" ]; } || \
  { [ "${OS_NAME}" = "Linux" ] && [ -z "${HOST_PLATFORM}" ]; }
}; then
  export HTTP_PROXY="${HTTP_PROXY:-http://127.0.0.1:18089}"
  export HTTPS_PROXY="${HTTPS_PROXY:-http://127.0.0.1:18089}"
  export NO_PROXY="${NO_PROXY:-localhost,127.0.0.1,::1}"
fi


