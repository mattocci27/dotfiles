# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=1000000  # This is about for a month
SAVEHIST=1000000  # This is about for a year

# Set options
setopt print_eight_bit # Japanese
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments  # '#' as comment
setopt auto_cd  # cd without cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_glob

autoload -Uz colors; colors

# Configure word selection behavior in ZLE (Zsh Line Editor)
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

export KEYTIMEOUT=1
