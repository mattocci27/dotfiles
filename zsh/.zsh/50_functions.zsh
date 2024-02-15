# Check for command availability
command_exists() {
  command -v "$1" &>/dev/null
}

# Enhance shell history search with fzf
fzf-history-widget() {
  local tac_command=$(command_exists tac && echo "tac" || echo "tail -r")
  BUFFER=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | sed 's/ *[0-9]* *//' | eval $tac_command | awk '!a[$0]++' | fzf --tiebreak=index --query="$LBUFFER" +s)
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget

# Navigate directories using cdr and fzf
fzf-get-destination-from-cdr() {
  cdr -l | sed -e 's/^[[:digit:]]*[[:blank:]]*//' | awk '{c=gsub("/","/"); print c,length($0),$0}' | sort -n | cut -d' ' -f1- | fzf --query="$LBUFFER" --height 40% --reverse
}

fzf-cdr() {
  local destination="$(fzf-get-destination-from-cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd '$destination'"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N fzf-cdr
bindkey '^x' fzf-cdr

# Attach to tmux sessions using fzf
fzf-tmux() {
  if command_exists tmux; then
    local session
    session=$(tmux list-sessions | fzf | awk -F':' '{print $1}')
    if [ -n "$session" ]; then
      _cool-fzf-insert-command-line "tmux attach -t $session"
    fi
  else
    echo "tmux not found."
  fi
}
zle -N fzf-tmux
bindkey '^t' fzf-tmux

# Navigate to repositories using ghq and fzf
fzf-src() {
  local dir
  dir=$(ghq list -p | fzf --query="$LBUFFER" --height 40% --reverse)
  if [ -n "$dir" ]; then
    BUFFER="cd '$dir'"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-src
bindkey '^g' fzf-src

# Utility function to insert a command into the Zsh command line and execute it
_cool-fzf-insert-command-line() {
  # Check if we are in an interactive shell
  if [[ $- == *i* ]]; then
    BUFFER="$1"  # Set the command into the Zsh command line buffer
    CURSOR=${#BUFFER}  # Move the cursor to the end of the buffer
    zle reset-prompt  # Clear the screen and reset the command prompt
  else
    # If not in an interactive shell, simulate executing the command
    print -z "$1"
  fi
}

# Improved SSH function with dynamic tmux window renaming
ssh() {
  if [[ -n $TMUX ]]; then
    local window_name=$(tmux display -p '#{window_name}')
    tmux rename-window -- "${@: -1}"
    command ssh "$@"
    tmux rename-window "$window_name"
  else
    command ssh "$@"
  fi
}

# Update X11 forwarding based on session type
update-x11-forwarding() {
  if [ -z "$STY" ] && [ -z "$TMUX" ]; then
    echo $DISPLAY > ~/.display.txt
  elif [ -f ~/.display.txt ]; then
    export DISPLAY=$(<~/.display.txt)
  fi
}

preexec() {
  [[ "$BASH_COMMAND" == "$PROMPT_COMMAND" ]] && return
  update-x11-forwarding
}
trap 'preexec' DEBUG

# Search directories with enhanced sorting using fzf
fzf-z-search() {
  if command_exists z; then
    local result=$(z | sort -rn | cut -c 12- | fzf --query="$LBUFFER" --height 40% --reverse)
    if [ -n "$result" ]; then
        BUFFER="cd '$result'"
        zle accept-line
    else
        zle reset-prompt
    fi
  else
    echo "z command not found."
  fi
}
zle -N fzf-z-search
bindkey '^f' fzf-z-search

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
