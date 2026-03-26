# ------------------------------
# Helpers
# ------------------------------
autossh-mini-check() {
  if ! command -v autossh >/dev/null 2>&1; then
    echo "❌ autossh not found. Install with: brew install autossh"
    return 1
  fi

  if ! ssh -G "$AUTOSSH_HOST" >/dev/null 2>&1; then
    echo "❌ SSH host '$AUTOSSH_HOST' is not resolvable via ssh config."
    echo "   Check ~/.ssh/config or AUTOSSH_HOST."
    return 1
  fi
}

# ------------------------------
# Main commands
# ------------------------------
autossh-mini() {
  local remote_port="${1:-$AUTOSSH_REMOTE_PORT}"

  autossh-mini-check || return 1

  echo "🚇 Starting reverse SSH tunnel"
  echo "   Host        : $AUTOSSH_HOST"
  echo "   Remote port : $remote_port"
  echo "   Forward to  : localhost:22"

  AUTOSSH_GATETIME=0 \
  AUTOSSH_POLL=30 \
  AUTOSSH_FIRST_POLL=30 \
  autossh -M 0 -N \
    -o "ServerAliveInterval=30" \
    -o "ServerAliveCountMax=3" \
    -o "ExitOnForwardFailure=yes" \
    -o "ConnectTimeout=10" \
    -R "${remote_port}:localhost:22" \
    "$AUTOSSH_HOST"
}

autossh-mini-bg() {
  local remote_port="${1:-$AUTOSSH_REMOTE_PORT}"

  autossh-mini-check || return 1

  echo "🚇 Starting reverse SSH tunnel in background"
  echo "   Host        : $AUTOSSH_HOST"
  echo "   Remote port : $remote_port"
  echo "   Forward to  : localhost:22"

  AUTOSSH_GATETIME=0 \
  AUTOSSH_POLL=30 \
  AUTOSSH_FIRST_POLL=30 \
  autossh -M 0 -N \
    -o "ServerAliveInterval=30" \
    -o "ServerAliveCountMax=3" \
    -o "ExitOnForwardFailure=yes" \
    -o "ConnectTimeout=10" \
    -R "${remote_port}:localhost:22" \
    "$AUTOSSH_HOST" \
    >>"$AUTOSSH_LOG_OUT" 2>>"$AUTOSSH_LOG_ERR" &

  disown
  echo "✅ autossh started in background"
}

autossh-mini-stop() {
  local remote_port="${1:-$AUTOSSH_REMOTE_PORT}"

  pkill -f "autossh.*-R ${remote_port}:localhost:22.*${AUTOSSH_HOST}" \
    && echo "🛑 autossh stopped (port ${remote_port})" \
    || echo "❌ No matching autossh process found"
}

autossh-mini-status() {
  local remote_port="${1:-$AUTOSSH_REMOTE_PORT}"

  echo "🔍 autossh process status (port ${remote_port})"
  pgrep -af "autossh.*-R ${remote_port}:localhost:22.*${AUTOSSH_HOST}" \
    || echo "❌ Not running"
}

autossh-mini-log() {
  echo "📜 autossh logs"
  echo "   stdout: $AUTOSSH_LOG_OUT"
  echo "   stderr: $AUTOSSH_LOG_ERR"
  echo "----------------------------------------"
  tail -n 50 "$AUTOSSH_LOG_ERR" 2>/dev/null || true
}

# ------------------------------
# launchd helpers
# ------------------------------
autossh-plist-load() {
  echo "🚀 Loading autossh plist"
  launchctl load "$AUTOSSH_PLIST"
}

autossh-plist-unload() {
  echo "🛑 Unloading autossh plist"
  launchctl unload "$AUTOSSH_PLIST"
}

autossh-plist-reload() {
  echo "🔄 Reloading autossh plist"
  launchctl unload "$AUTOSSH_PLIST" 2>/dev/null
  launchctl load "$AUTOSSH_PLIST"
  echo "✅ Done"
}

autossh-plist-status() {
  echo "🔍 Checking autossh plist status"
  launchctl list | grep "$AUTOSSH_LABEL" || echo "❌ Not running"
}

autossh-plist-log() {
  autossh-mini-log
}
