# Zed configuration

Date: 2026-09-04

## Goal

Add a small, native Zed package to the dotfiles repository while keeping the existing VS Code/vscode-neovim setup and standalone Neovim configuration independent.

## Current state

- Added `zed/.config/zed/` with settings, keymap, tasks, and native snippets.
- Existing Stow deployment automatically discovers `zed/`; no second dotfile manager was introduced.
- macOS Homebrew now includes the `zed` cask.
- Zed uses native Vim mode, Space leader, immediate native which-key, native file/project search, Git/LSP/terminal actions, Gruvbox Material, and minimal UI chrome.
- R uses the `r` and `air` extensions, Air-first formatting, and `r_language_server` for language intelligence.
- Tasks start `radian`, run `quarto preview`/`quarto render`, and render R Markdown through `Rscript`.
- `.qmd` uses the current Quarto extension; `.Rmd`/`.rmd` remain Markdown.

## Important findings and decisions

- Zed 1.18.0 is installed locally. Its CLI has no standalone configuration-validation command, so validation used JSON parsing, action checks against the installed binary/current action catalog, shell syntax checks, and an isolated Stow round trip.
- Zed’s key syntax requires `shift-g`-style shifted keys; literal uppercase leader continuations were corrected.
- Bare `space` is explicitly mapped to `null` in normal-mode editor context so it does not trigger Zed’s default Vim wrapping action before leader sequences.
- The current Quarto extension is registry-listed but young (`0.0.1`). It provides a distinct Quarto language, syntax/injection support, outlines, and snippets, but not notebook or chunk execution.
- Copilot/edit predictions are enabled for Quarto and programming languages, while ordinary Markdown (including R Markdown), YAML, and plain text are disabled using language settings and filename globs.
- Existing malformed/obsolete VS Code snippets were not copied. Only valid, useful native Zed snippets were ported.

## Files changed

- `zed/.config/zed/settings.json`
- `zed/.config/zed/keymap.json`
- `zed/.config/zed/tasks.json`
- `zed/.config/zed/snippets/markdown.json`
- `zed/.config/zed/snippets/quarto.json`
- `deps/Brewfile`
- `setup.sh`
- `README.md`

## Validation

- All five Zed JSON files parse with `jq`.
- No duplicate keybindings; leader mappings are confined to normal mode and `jj` is confined to insert mode.
- `bash -n` passes for `install.sh`, `setup.sh`, and the Stow deploy script.
- `git diff --check` passes.
- Temporary Stow install/delete test passes.
- Homebrew recognizes the `zed` cask.
- Local tools available: radian 0.6.16, Quarto 1.10.18, R 4.6.1.

## Unresolved issues

- `languageserver` and `lintr` are not currently installed in the local R library; setup option 6 now installs them.
- Air’s standalone CLI is not currently on PATH; the Zed Air extension supplies its integration.
- Radian remains terminal/task-based; there is no custom send-selection-to-REPL bridge.
- Quarto/RMarkdown preview/render is task-driven and does not provide RStudio-style notebook/chunk execution.

## Next steps

1. Run `sh setup.sh` option 2 to Stow the package into `~/.config/zed`.
2. Run option 6 to install the R language-server and lint dependencies.
3. Open Zed, sign in to GitHub Copilot, and allow the configured extensions to install.
4. Smoke-test `SPC f`, `SPC /`, `SPC l`, `SPC t r`, `SPC q p`, and `Ctrl-h/j/k/l` in a representative project.

Do not redo the VS Code or standalone Neovim inspection/configuration; those remain intentionally separate.
