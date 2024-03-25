# Enable aliases to be sudo'ed
alias sudo='sudo '

# Use 'exa' for enhanced listing if available
if command -v exa >/dev/null 2>&1; then
  alias ls='exa -F'
  alias la='exa -a -F'
  alias ll='exa -l'
  alias tree='exa --tree'
else
  # Fallback to default commands if 'exa' is not installed
  alias ll='ls -l'
  alias la='ls -la'
  alias tree='tree'
fi

# Use 'bat' may be installed as 'batcat' on some systems
if command -v batcat >/dev/null 2>&1; then
  alias bat='batcat'
fi

# Safe versions of file manipulation commands
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'


# from mischavandenburg
alias db='cd $HOME/Dropbox'
alias sb="cd \$SECOND_BRAIN"
alias in="cd \$SECOND_BRAIN/0-Inbox/"

alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='nvim $(fp)'
alias ff="find . -type d | fzf"

# Simplify directory creation
alias mkdir='mkdir -p'

# Global aliases for filtering output
alias -g L='| less'
alias -g G='| grep'

# Editor and file manager shortcuts
alias v='vim'

# Open files with the default application (Linux-specific)
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  alias open='xdg-open'
fi

# Clipboard management
if command -v pbcopy >/dev/null 2>&1; then
  # macOS
  alias -g C='| pbcopy'
elif command -v xsel >/dev/null 2>&1; then
  # Linux
  alias -g C='| xsel --input --clipboard'
elif command -v putclip >/dev/null 2>&1; then
  # Cygwin
  alias -g C='| putclip'
fi

# ghq
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'

if [ "$(uname)" = "Darwin" ]; then
    alias ghq='export GHQ_ROOT=$HOME/Dropbox/3-Resources/ghq; command ghq'
fi
