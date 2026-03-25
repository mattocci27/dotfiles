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

autoload -Uz add-zsh-hook
add-zsh-hook preexec update-x11-forwarding

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

realpath_safe() {
  python -c 'import os,sys; print(os.path.abspath(os.path.expanduser(sys.argv[1])))' "$1"
}

make_stub() {
  local name="$1"
  local arg2="$2"
  local arg3="$3"
  local arg4="$4"

  if [[ -z "$name" ]]; then
    echo "Usage:"
    echo "  make_stub <name> [real_path] [status] [stub_root]"
    echo "  make_stub <name> <status> <stub_root>"
    return 1
  fi

  local real_path stub_status stub_root

  if [[ -d "$arg2" || "$arg2" == /* || "$arg2" == ~* || "$arg2" == .* ]]; then
    real_path="$arg2"
    stub_status="${arg3:-unknown}"
    stub_root="${arg4:-.}"
  else
    real_path="./$name"
    stub_status="${arg2:-unknown}"
    stub_root="${arg3:-.}"
  fi

  stub_root="$(realpath_safe "$stub_root")"
  real_path="$(realpath_safe "$real_path")"

  local stub_dir="$stub_root/${name%.stub}.stub"

  if [[ -e "$stub_dir/README.md" ]]; then
    echo "Error: stub already exists: $stub_dir"
    return 1
  fi

  mkdir -p "$stub_dir"

  local size="missing"
  if [[ -e "$real_path" ]]; then
    size=$(du -sh "$real_path" 2>/dev/null | awk '{print $1}')
  fi

  local created
  created=$(date "+%Y-%m-%d")

  cat > "$stub_dir/README.md" <<EOF
# $name

Location: $real_path
Status: $stub_status
Created: $created
Size: $size
EOF

  touch "$stub_dir/.stub"

  echo "✅ Created: $stub_dir"
}

un_stub() {
  local stub_dir="$1"

  stub_dir="${stub_dir%%/}"

  if [[ ! -f "$stub_dir/README.md" ]]; then
    echo "Error: README.md not found"
    return 1
  fi

  local real_path remote_path

  real_path=$(grep "^Location: " "$stub_dir/README.md" | sed 's/^Location: //')
  remote_path=$(grep "^Remote: " "$stub_dir/README.md" | sed 's/^Remote: //')

  if [[ -z "$real_path" || -z "$remote_path" ]]; then
    echo "Error: Missing metadata"
    return 1
  fi

  if [[ -e "$real_path" ]]; then
    echo "⚠️  Target exists: $real_path"
    return 1
  fi

  mkdir -p "$(dirname "$real_path")"

  echo "⏳ Downloading..."
  rclone copy "$remote_path" "$real_path" --progress

  if [[ $? -eq 0 ]]; then
    rm -rf "$stub_dir"
    echo "✅ Restored & stub removed"
  else
    echo "❌ Failed"
    return 1
  fi
}


mini-host() {
  if ssh -o ConnectTimeout=1 mac-mini-local exit >/dev/null 2>&1; then
    echo "mac-mini-local"
  else
    echo "mac-mini-sakura"
  fi
}

push-mini() {
  local host ans
  host=$(mini-host)
  echo "Using host: $host"

  echo "🔍 DRY RUN (Air → $host)"
  rsync -av --delete --dry-run \
    --exclude '.DS_Store' \
    --exclude '2-Areas/Research/MS/On-hold/' \
    --exclude '2-Areas/Research/MS/Published/' \
    --exclude '2-Areas/Research/MS/On-hold.stub/' \
    --exclude '2-Areas/Research/MS/Published.stub/' \
    --exclude '4-Archives/' \
    ~/Workspace/ \
    "${host}:/Volumes/ThunderDrive/DataVault/Workspace/" || return 1

  echo
  read "ans?🚀 Execute? (y/N): "
  [[ "$ans" != "y" ]] && echo "❌ Cancelled" && return 0

  echo "🚀 EXECUTE (Air → $host)"
  rsync -av --delete \
    --exclude '.DS_Store' \
    --exclude '2-Areas/Research/MS/On-hold/' \
    --exclude '2-Areas/Research/MS/Published/' \
    --exclude '2-Areas/Research/MS/On-hold.stub/' \
    --exclude '2-Areas/Research/MS/Published.stub/' \
    --exclude '4-Archives/' \
    ~/Workspace/ \
    "${host}:/Volumes/ThunderDrive/DataVault/Workspace/"
}

pull-mini() {
  local host ans
  host=$(mini-host)
  echo "Using host: $host"

  echo "🔍 DRY RUN ($host → Air)"
  rsync -av --delete --dry-run \
    --exclude '.DS_Store' \
    --exclude '2-Areas/Research/MS/On-hold/' \
    --exclude '2-Areas/Research/MS/Published/' \
    --exclude '2-Areas/Research/MS/On-hold.stub/' \
    --exclude '2-Areas/Research/MS/Published.stub/' \
    "${host}:/Volumes/ThunderDrive/DataVault/Workspace/" \
    ~/Workspace/ || return 1

  echo
  read "ans?🚀 Execute? (y/N): "
  [[ "$ans" != "y" ]] && echo "❌ Cancelled" && return 0

  echo "🚀 EXECUTE ($host → Air)"
  rsync -av --delete \
    --exclude '.DS_Store' \
    --exclude '2-Areas/Research/MS/On-hold/' \
    --exclude '2-Areas/Research/MS/Published/' \
    --exclude '2-Areas/Research/MS/On-hold.stub/' \
    --exclude '2-Areas/Research/MS/Published.stub/' \
    "${host}:/Volumes/ThunderDrive/DataVault/Workspace/" \
    ~/Workspace/
}

push-ms() {
  local host ans section name src dst

  section="$1"
  name="$2"

  if [[ -z "$section" || -z "$name" ]]; then
    echo "Usage: push-ms <On-hold|Published> <name>"
    return 1
  fi

  case "$section" in
    On-hold|Published) ;;
    *)っj
      echo "Error: section must be 'On-hold' or 'Published'"
      return 1
      ;;
  esac

  host=$(mini-host)

  src="$HOME/Workspace/2-Areas/Research/MS/${section}.stub/${name}.stub/"
  dst="/Volumes/ThunderDrive/DataVault/Workspace/2-Areas/Research/MS/${section}.stub/${name}.stub/"

  if [[ ! -d "$src" ]]; then
    echo "Error: source not found: $src"
    return 1
  fi

  echo "Using host: $host"
  echo "🔍 DRY RUN (Air → $host)"
  rsync -av --delete --dry-run \
    --exclude '.DS_Store' \
    "$src" \
    "${host}:$dst" || return 1

  echo
  read "ans?🚀 Execute push-ms? (y/N): "
  [[ "$ans" != "y" ]] && echo "❌ Cancelled" && return 0

  echo "🚀 EXECUTE (Air → $host)"
  rsync -av --delete \
    --exclude '.DS_Store' \
    "$src" \
    "${host}:$dst"
}


pull-ms() {
  local host ans section name src dst

  section="$1"
  name="$2"

  if [[ -z "$section" || -z "$name" ]]; then
    echo "Usage: pull-ms <On-hold|Published> <name>"
    return 1
  fi

  case "$section" in
    On-hold|Published) ;;
    *)
      echo "Error: section must be 'On-hold' or 'Published'"
      return 1
      ;;
  esac

  host=$(mini-host)

  src="/Volumes/ThunderDrive/DataVault/Workspace/2-Areas/Research/MS/${section}.stub/${name}.stub/"
  dst="$HOME/Workspace/2-Areas/Research/MS/${section}.stub/${name}.stub/"

  echo "Using host: $host"
  echo "🔍 DRY RUN ($host → Air)"
  rsync -av --delete --dry-run \
    --exclude '.DS_Store' \
    "${host}:$src" \
    "$dst" || return 1

  echo
  read "ans?🚀 Execute pull-ms? (y/N): "
  [[ "$ans" != "y" ]] && echo "❌ Cancelled" && return 0

  echo "🚀 EXECUTE ($host → Air)"
  rsync -av --delete \
    --exclude '.DS_Store' \
    "${host}:$src" \
    "$dst"
}
