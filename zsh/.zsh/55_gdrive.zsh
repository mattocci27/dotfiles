rclone-common-opts() {
  echo \
    --exclude ".DS_Store" \
    --exclude "Docs/**" \
    --exclude "Shared/**" \
    --exclude "tmp/**" \
    --exclude "**/renv/**" \
    --exclude "**/.git/**" \
    --exclude "**/.Rproj.user/**" \
    --exclude "**/*.tmp" \
    --transfers=8 \
    --checkers=8 \
    --fast-list \
    --progress \
    --stats=10s \
    --create-empty-src-dirs
}


# Top-level dirs to back up
GDRIVE_DIRS=(
  0-Inbox
  1-Projects
  2-Areas
  3-Resources
  4-Archives
)

gdrive-run-dir() {
  local action="$1"   # copy | sync
  local dir="$2"
  local mode="${3:-ask}"
  local prompt="$4"
  local banner="$5"
  local -a opts

  [[ -z "$action" || -z "$dir" ]] && {
    echo "❌ Usage: gdrive-run-dir <copy|sync> <dir> [ask|run|dry]"
    return 1
  }

  [[ "$action" != "copy" && "$action" != "sync" ]] && {
    echo "❌ action must be 'copy' or 'sync'"
    return 1
  }

  [[ ! -d "$LOCAL/$dir" ]] && {
    echo "❌ Directory not found: $LOCAL/$dir"
    return 1
  }

  opts=($(rclone-common-opts))

  echo "$banner"
  echo "   Dir    : $dir"
  echo "   Source : $LOCAL/$dir"
  echo "   Target : $REMOTE_DIR/$dir"
  echo

  local -a cmd=(
    rclone "$action"
    "$LOCAL/$dir" "$REMOTE_DIR/$dir"
    "${opts[@]}"
  )

  case "$mode" in
    dry)
      echo "🔍 DRY RUN"
      "${cmd[@]}" --dry-run || return 1
      ;;
    run)
      echo "🚀 EXECUTE ${action:u} ($dir)"
      "${cmd[@]}" || return 1
      ;;
    ask)
      echo "🔍 DRY RUN"
      "${cmd[@]}" --dry-run || return 1
      echo
      read "ans?$prompt"
      case "$action" in
        copy)
          [[ "$ans" != "y" ]] && echo "❌ Cancelled" && return 0
          ;;
        sync)
          [[ "$ans" != "yes" ]] && echo "❌ Cancelled" && return 0
          ;;
      esac
      echo "🚀 EXECUTE ${action:u} ($dir)"
      "${cmd[@]}" || return 1
      ;;
    *)
      echo "❌ Invalid mode: $mode (use ask|run|dry)"
      return 1
      ;;
  esac
}

gdrive-run-all() {
  local action="$1"   # copy | sync
  local mode="${2:-ask}"
  local dir
  local header prompt banner

  [[ "$action" != "copy" && "$action" != "sync" ]] && {
    echo "❌ Usage: gdrive-run-all <copy|sync> [ask|run|dry]"
    return 1
  }

  if [[ "$action" == "copy" ]]; then
    header="☁️ Backup Workspace → Google Drive"
    prompt="🚀 Execute backup for all dirs? (y/N): "
    banner="☁️ Copy"
  else
    header="⚠️ ONE-TIME SYNC (destructive)"
    prompt="🚨 REALLY sync ALL dirs? type 'yes': "
    banner="⚠️ ONE-TIME SYNC (destructive)"
  fi

  echo "$header"
  [[ "$action" == "sync" ]] && echo "   This will DELETE files on remote!"
  echo "   Source : $LOCAL"
  echo "   Target : $REMOTE_DIR"
  echo "   Mode   : $mode"
  echo

  case "$mode" in
    dry)
      for dir in "${GDRIVE_DIRS[@]}"; do
        echo "===== $dir ====="
        gdrive-run-dir "$action" "$dir" dry "" "$banner" || return 1
        echo
      done
      ;;
    run)
      for dir in "${GDRIVE_DIRS[@]}"; do
        echo "===== $dir ====="
        gdrive-run-dir "$action" "$dir" run "" "$banner" || return 1
        echo
      done
      ;;
    ask)
      echo "🔍 DRY RUN (all dirs)"
      for dir in "${GDRIVE_DIRS[@]}"; do
        echo "===== $dir ====="
        gdrive-run-dir "$action" "$dir" dry "" "$banner" || return 1
        echo
      done

      read "ans?$prompt"
      if [[ "$action" == "copy" ]]; then
        [[ "$ans" != "y" ]] && echo "❌ Cancelled" && return 0
      else
        [[ "$ans" != "yes" ]] && echo "❌ Cancelled" && return 0
      fi

      echo "🚀 EXECUTE ${action:u} (all dirs)"
      for dir in "${GDRIVE_DIRS[@]}"; do
        echo "===== $dir ====="
        gdrive-run-dir "$action" "$dir" run "" "$banner" || return 1
        echo
      done
      ;;
    *)
      echo "❌ Invalid mode: $mode (use ask|run|dry)"
      return 1
      ;;
  esac
}

# Public commands
gdrive-copy-dir() {
  gdrive-run-dir copy "$1" "${2:-ask}" "🚀 Execute copy '$1'? (y/N): " "☁️ Copy"
}

gdrive-sync-dir() {
  gdrive-run-dir sync "$1" "${2:-ask}" "🚨 REALLY sync '$1'? type 'yes': " "⚠️ ONE-TIME SYNC (destructive)"
}

gdrive-backup() {
  gdrive-run-all copy "${1:-ask}"
}

gdrive-sync-once() {
  gdrive-run-all sync "${1:-ask}"
}
