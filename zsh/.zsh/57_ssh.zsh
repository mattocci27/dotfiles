# macOS lets the system keychain handle ssh-agent; manage manually only on Linux
if is_linux; then
  SSH_ENV="$HOME/.ssh/agent-environment"

  start_agent() {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
  }

  if [[ -f "${SSH_ENV}" ]]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep "${SSH_AGENT_PID}" | grep 'ssh-agent$' > /dev/null || start_agent
  else
    start_agent
  fi
fi
