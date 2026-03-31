rclone-common-opts() {
  local exclude_file="$GDRIVE_RCLONE_EXCLUDES"

  if [[ -f "$exclude_file" ]]; then
    echo \
      --exclude-from "$exclude_file" \
      --transfers=8 \
      --checkers=8 \
      --fast-list \
      --progress \
      --stats=10s \
      --create-empty-src-dirs
  else
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
  fi
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

  [[ -z "$GDRIVE_REMOTE_DIR" ]] && {
    echo "❌ GDRIVE_REMOTE_DIR is not set"
    return 1
  }

  [[ ! -d "$GDRIVE_LOCAL/$dir" ]] && {
    echo "❌ Directory not found: $GDRIVE_LOCAL/$dir"
    return 1
  }

  opts=($(rclone-common-opts))

  echo "$banner"
  echo "   Dir    : $dir"
  echo "   Source : $GDRIVE_LOCAL/$dir"
  echo "   Target : $GDRIVE_REMOTE_DIR/$dir"
  echo

  local -a cmd=(
    rclone "$action"
    "$GDRIVE_LOCAL/$dir" "$GDRIVE_REMOTE_DIR/$dir"
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
  echo "   Source : $GDRIVE_LOCAL"
  echo "   Target : $GDRIVE_REMOTE_DIR"
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
