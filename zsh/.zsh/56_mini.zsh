mini-host() {
  if ssh -q -o ConnectTimeout=1 -o BatchMode=yes mac-mini-local exit >/dev/null 2>&1; then
    echo "mac-mini-local"
  else
    echo "mac-mini-sakura"
  fi
}

mini-rsync-build-opts() {
  local stamp="$1"
  local exclude_file="${DOTFILES_ROOT:-$HOME/dotfiles}/scripts/.sync/mini-rsync.excludes"

  MINI_RSYNC_OPTS=(
    -a
    -v
    --delete
    --itemize-changes
    --human-readable
    --partial
    --backup
    "--backup-dir=.rsync-trash/${stamp}"
  )

  if [[ -f "$exclude_file" ]]; then
    MINI_RSYNC_OPTS+=(--exclude-from "$exclude_file")
  else
    MINI_RSYNC_OPTS+=(
      --exclude '.DS_Store'
      --exclude '.rsync-trash/'
      --exclude '2-Areas/Research/MS/On-hold/'
      --exclude '2-Areas/Research/MS/Published/'
      --exclude '4-Archives/'
    )
  fi
}

push-mini() {
  local host ans stamp
  host=$(mini-host)
  stamp=$(date "+%Y%m%d-%H%M%S")
  mini-rsync-build-opts "$stamp"
  echo "Using host: $host"

  echo "🔍 DRY RUN (Air → $host)"
  rsync "${MINI_RSYNC_OPTS[@]}" --dry-run \
    ~/Workspace/ \
    "${host}:/Volumes/ThunderDrive/DataVault/Workspace/" || return 1

  echo
  read "ans?🚀 Execute? (y/N): "
  [[ "$ans" != "y" ]] && echo "❌ Cancelled" && return 0

  echo "🚀 EXECUTE (Air → $host)"
  rsync "${MINI_RSYNC_OPTS[@]}" \
    ~/Workspace/ \
    "${host}:/Volumes/ThunderDrive/DataVault/Workspace/"
}

pull-mini() {
  local host ans stamp
  host=$(mini-host)
  stamp=$(date "+%Y%m%d-%H%M%S")
  mini-rsync-build-opts "$stamp"
  echo "Using host: $host"

  echo "🔍 DRY RUN ($host → Air)"
  rsync "${MINI_RSYNC_OPTS[@]}" --dry-run \
    "${host}:/Volumes/ThunderDrive/DataVault/Workspace/" \
    ~/Workspace/ || return 1

  echo
  read "ans?🚀 Execute? (y/N): "
  [[ "$ans" != "y" ]] && echo "❌ Cancelled" && return 0

  echo "🚀 EXECUTE ($host → Air)"
  rsync "${MINI_RSYNC_OPTS[@]}" \
    "${host}:/Volumes/ThunderDrive/DataVault/Workspace/" \
    ~/Workspace/
}

push-ms() {
  local host ans section name src dst stamp

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
  stamp=$(date "+%Y%m%d-%H%M%S")
  mini-rsync-build-opts "$stamp"

  src="$HOME/Workspace/2-Areas/Research/MS/${section}/${name}.stub/"
  dst="/Volumes/ThunderDrive/DataVault/Workspace/2-Areas/Research/MS/${section}/${name}.stub/"

  if [[ ! -d "$src" ]]; then
    echo "Error: source not found: $src"
    return 1
  fi

  echo "Using host: $host"
  echo "🔍 DRY RUN (Air → $host)"
  rsync "${MINI_RSYNC_OPTS[@]}" --dry-run \
    "$src" \
    "${host}:$dst" || return 1

  echo
  read "ans?🚀 Execute push-ms? (y/N): "
  [[ "$ans" != "y" ]] && echo "❌ Cancelled" && return 0

  echo "🚀 EXECUTE (Air → $host)"
  rsync "${MINI_RSYNC_OPTS[@]}" \
    "$src" \
    "${host}:$dst"
}


pull-ms() {
  local host ans section name src dst stamp

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
  stamp=$(date "+%Y%m%d-%H%M%S")
  mini-rsync-build-opts "$stamp"

  src="/Volumes/ThunderDrive/DataVault/Workspace/2-Areas/Research/MS/${section}/${name}.stub/"
  dst="$HOME/Workspace/2-Areas/Research/MS/${section}/${name}.stub/"

  echo "Using host: $host"
  echo "🔍 DRY RUN ($host → Air)"
  rsync "${MINI_RSYNC_OPTS[@]}" --dry-run \
    "${host}:$src" \
    "$dst" || return 1

  echo
  read "ans?🚀 Execute pull-ms? (y/N): "
  [[ "$ans" != "y" ]] && echo "❌ Cancelled" && return 0

  echo "🚀 EXECUTE ($host → Air)"
  rsync "${MINI_RSYNC_OPTS[@]}" \
    "${host}:$src" \
    "$dst"
}
