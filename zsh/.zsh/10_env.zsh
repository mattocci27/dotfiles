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
#export DISPLAY=:0 
export DISPLAY=localhost:0.0

# pyenv
if [ `uname` = "Darwin" ]; then
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
    fi
fi

