mini-host() {
  if ssh -q -o ConnectTimeout=1 -o BatchMode=yes mac-mini-local exit >/dev/null 2>&1; then
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
    --exclude '4-Archives/' \
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
    --exclude '4-Archives/' \
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
    *)
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
