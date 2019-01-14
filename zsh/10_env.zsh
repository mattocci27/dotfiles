# locale
# without this, tmux does not recognize some fonts
export LANG=en_US.UTF-8

# default editor
VISUAL=nvim; export VISUAL EDITOR=nvim; export EDITOR

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='nvim'
fi
