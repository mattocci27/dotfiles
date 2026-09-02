---
name: project-log
description: >
  Save the current coding or research session as a concise Markdown
  project log. Use when the user asks to save, record, log, document,
  wrap up, or leave a handoff for the current work.
---

# Project Log

When this skill is used:

1. Identify the current project root.
2. Look for an existing `logs/` directory.
3. Inspect recent logs and follow the project's existing naming
   and formatting conventions.
4. Summarize the current work, including:
   - goal
   - important findings
   - decisions and reasoning
   - files changed
   - unresolved issues
   - next steps
5. Do not dump the conversation verbatim.
6. Write the log to:
   `logs/YYYY-MM-DD-<short-topic>.md`
7. Never overwrite an existing log unless explicitly requested.
8. Do not git commit or push unless explicitly requested.

For handoff logs, emphasize:
- current state
- decisions already made
- what should not be redone
- remaining work
- best next action
