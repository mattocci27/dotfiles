#!/usr/bin/env bash
set -euo pipefail

realpath_safe() {
  python3 -c 'import os,sys; print(os.path.abspath(os.path.expanduser(sys.argv[1])))' "$1"
}

make_stub() {
  local name="${1-}"
  local arg2="${2-}"
  local arg3="${3-}"
  local arg4="${4-}"

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
    echo "⏭️ Skip (exists): $stub_dir"
    return 0
  fi

  mkdir -p "$stub_dir"

  local created
  created=$(date "+%Y-%m-%d")

  local size_line=""
  if [[ -e "$real_path" ]]; then
    local size
    size=$(du -sh "$real_path" 2>/dev/null | awk '{print $1}' || true)
    if [[ -n "$size" ]]; then
      size_line="Size: $size"
    else
      size_line="Size: remote-only"
    fi
  fi

  cat >"$stub_dir/README.md" <<EOF
# $name

Location: $real_path
Status: $stub_status
Created: $created
${size_line}
EOF

  touch "$stub_dir/.stub"

  echo "✅ Created: $stub_dir"
}

SRC="$HOME/Cloud/GDrive/2-Areas/Research/MS"
DST="$HOME/Workspace/2-Areas/Research/MS"

process_dir() {
  local status="$1"
  local src_dir="$SRC/$status"
  local dst_dir="$DST/$status"

  echo "=== Processing: $status ==="
  mkdir -p "$dst_dir"

  find "$src_dir" -mindepth 1 -maxdepth 1 -type d | while read -r path; do
    local name
    name="$(basename "$path")"
    echo "→ $name"
    make_stub "$name" "$path" "$status" "$dst_dir"
  done
}

process_dir "Published"
process_dir "On-hold"
