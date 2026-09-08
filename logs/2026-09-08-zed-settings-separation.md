# Zed Settings Separation

## Goal

Keep machine-specific Zed SSH connection state local while retaining reusable Zed settings and keybindings in the public dotfiles repository.

## Important findings

- Zed files were managed by GNU Stow under `zed/.config/zed/`.
- Both `~/.config/zed/settings.json` and `~/.config/zed/keymap.json` were symlinks into the repository.
- The tracked settings file contained a top-level `ssh_connections` entry alongside reusable agent, model, UI, font, theme, Vim, language, terminal, extension, and edit-prediction settings.
- Deployment used two paths: `scripts/.dotscripts/deploy.sh` and the direct `install.sh` bootstrap.

## Changes and decisions

- Preserved the existing `zed/.config/zed/` layout rather than introducing a competing configuration structure.
- Safely copied the live settings through a temporary local file and replaced the settings symlink with a normal writable file, preserving its existing contents and SSH state.
- Added executable `zed/sync-settings.sh`, which requires `jq`, requires a local live settings file, removes only `.ssh_connections`, validates the generated JSON, and atomically replaces the repository copy.
- Added a symlink guard to the sync script so it refuses to run before migration.
- Updated both Stow deployment entry points to exclude Zed `settings.json` and `sync-settings.sh`, while continuing to deploy `keymap.json` and other Zed files.
- Left `.gitignore` unchanged because the live settings file is outside the repository and the deployment exclusions prevent it from being recreated as a symlink.
- The existing Vim-style `keymap.json` design was left intact.

## Files changed

- `zed/.config/zed/settings.json` — sanitized public copy
- `zed/sync-settings.sh` — new executable synchronization script
- `scripts/.dotscripts/deploy.sh` — Zed-specific Stow exclusions
- `install.sh` — matching exclusions for direct bootstrap

## Validation

- `jq` confirmed the public settings are valid JSON and have no `ssh_connections` key.
- `jq` confirmed the live settings retain a non-empty `ssh_connections` list.
- A value-free comparison confirmed the public settings equal the live settings with only `ssh_connections` removed.
- Shell syntax checks passed for the new script and both deployment scripts.
- Confirmed the live settings path is a regular file and `keymap.json` remains a symlink.
- Zed diagnostics reported no errors or warnings for `keymap.json`.
- `git diff --stat` showed changes to the two deployment scripts, the sanitized settings file, and the existing keymap change; the new sync script is untracked and ready to add.

## Unresolved issues

None. The sync script should be run manually after Zed changes that should be reflected in the public settings copy.

## Next steps

Run `./zed/sync-settings.sh` whenever reusable Zed settings change, review the sanitized diff, and add the new script with the intended configuration changes when ready to commit.
