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

# Simplify directory creation
alias mkdir='mkdir -p'

# Global aliases for filtering output
alias -g L='| less'
alias -g G='| grep'

# Editor and file manager shortcuts
alias v='vim'
alias ranger='ranger.py'

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
