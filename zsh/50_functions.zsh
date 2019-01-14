# function for peco
function peco-select-history() {
  local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
      eval $tac | \
      peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# ### search a destination from cdr list
function peco-get-destination-from-cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  awk '{c=gsub("/","/"); print c,length($0),$0}' | \
  sort -n | \
  cut -d' ' -f1- | \
  peco --query "$LBUFFER"
}

### search a destination from cdr list and cd the destination
function peco-cdr() {
  local destination="$(peco-get-destination-from-cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd $destination"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N peco-cdr
bindkey '^x' peco-cdr


##
# select tmux session
#

function _cool-peco-insert-command-line() {
  if zle; then
    BUFFER=$1
    CURSOR=$#BUFFER
    zle clear-screen
  else
    print -z $1
  fi
}

function peco-tmux() {
  local res
  res=$(tmux list-sessions | peco | awk -F':' '{print $1}')
  if [ -n "$res" ]; then
    _cool-peco-insert-command-line "tmux attach -t $res"
  fi
}
zle -N peco-tmux
bindkey '^t' peco-tmux

##
# select git repository by ghq command
#
function peco-ghq() {
  local res
  res=$(ghq list | peco --query "$LBUFFER")
  if [ -n "$res" ]; then
    _cool-peco-insert-command-line "cd $(ghq root)/$res"
  fi
}
zle -N peco-ghq
bindkey '^g' peco-ghq

# ghq
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# display ssh
# -----------------------------------------------------------------
function ssh() {
  if [[ -n $(printenv TMUX) ]]
  then
    local window_name=$(tmux display -p '#{window_name}')
    tmux rename-window -- "$@[-1]" # zsh specified
    # tmux rename-window -- "${!#}" # for bash
    command ssh $@
    tmux rename-window $window_name
  else
    command ssh $@
  fi
}

