# Zed Project Panel Keybindings

## Goal

Add Vim-style file-management shortcuts to the existing Zed Project Panel keybindings while preserving the user’s working navigation bindings.

## Important findings

- The existing `ProjectPanel && not_editing` context contained four pane-navigation bindings:
  - `ctrl-h` → `workspace::ActivatePaneLeft`
  - `ctrl-j` → `terminal_panel::ToggleFocus`
  - `ctrl-k` → `workspace::ActivatePaneUp`
  - `ctrl-l` → `workspace::FocusCenterPane`
- No explicit `j`, `k`, `h`, or `l` bindings were present in the repository file; those come from Zed’s Vim defaults and were left untouched.
- Native Zed actions were verified for file creation, directory creation, rename, delete, cut, copy, paste, permanent open, directory search, and editor focus.
- The `ProjectPanel && not_editing` context prevents single-letter bindings from firing while entering or renaming filenames.

## Changes and decisions

Updated `zed/.config/zed/keymap.json` with:

- `a` → `project_panel::NewFile`
- `shift-a` → `project_panel::NewDirectory`
- `r` → `project_panel::Rename`
- `d` → `project_panel::Delete`
- `x` → `project_panel::Cut`
- `y` → `project_panel::Copy`
- `p` → `project_panel::Paste`
- `o` and `enter` → `project_panel::OpenPermanent`
- `/` → `project_panel::NewSearchInDirectory`
- `q` → `workspace::FocusCenterPane`

Existing defaults for `d`, `o`, `p`, `x`, and `enter` were checked before being intentionally overridden to match the requested behavior.

`escape` was not added because its existing `menu::Cancel` behavior is useful for cancelling menus and related Project Panel interactions.

## Validation

- `python3 -m json.tool zed/.config/zed/keymap.json` passed.
- Zed diagnostics reported no errors or warnings.
- The diff was limited to the existing Project Panel binding section.

## Unresolved issues

None. The only requested binding omitted was `Escape`, intentionally preserved as Zed’s existing cancel action.

## Next steps

No further work is required unless the keybindings need to be tested interactively in Zed or adjusted for a future Zed default-keymap change.
