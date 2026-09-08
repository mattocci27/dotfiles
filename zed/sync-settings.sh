#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
SOURCE="${HOME}/.config/zed/settings.json"
DESTINATION="${SCRIPT_DIR}/.config/zed/settings.json"

if ! command -v jq >/dev/null 2>&1; then
  printf '%s\n' 'jq is required to sync Zed settings.' >&2
  exit 1
fi

if [[ ! -f "$SOURCE" ]]; then
  printf 'Zed settings file not found: %s\n' "$SOURCE" >&2
  exit 1
fi

if [[ -L "$SOURCE" ]]; then
  printf 'Refusing to sync while the live Zed settings file is a symlink: %s\n' "$SOURCE" >&2
  exit 1
fi

TEMP_FILE="$(mktemp "${DESTINATION}.tmp.XXXXXX")"
cleanup() {
  rm -f "$TEMP_FILE"
}
trap cleanup EXIT

jq 'del(.ssh_connections)' "$SOURCE" > "$TEMP_FILE"
jq empty "$TEMP_FILE"
mv "$TEMP_FILE" "$DESTINATION"
trap - EXIT
