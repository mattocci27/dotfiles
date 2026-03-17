#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")/../.." && pwd -P)"
TARGET="$HOME"

rm -f "$TARGET/.DS_Store"

# List directories to stow
DOTFILES_DIRS=$(
  find "$DOTFILES" -mindepth 1 -maxdepth 1 -type d \
    ! -name tests \
    ! -name deps \
    ! -name fonts \
    -exec basename {} \;
)

for F in $DOTFILES_DIRS; do
  echo "~ Installing :: $F"

  # Remove previous links
  stow -D --dotfiles --dir "$DOTFILES" --target "$TARGET" "$F" 2>/dev/null || true

  # Install new links
  stow --dotfiles --dir "$DOTFILES" --target "$TARGET" "$F"
done

distro="$(uname)"

if [ "$distro" = "Darwin" ]; then
  mkdir -p "$HOME/Library/Application Support/Code/User/snippets"
  mkdir -p "$HOME/.R"

  for f in "$DOTFILES"/Code/.config/Code/User/snippets/*; do
    [ -e "$f" ] || continue
    ln -snf "$f" "$HOME/Library/Application Support/Code/User/snippets/"
  done

  for f in "$DOTFILES"/Code/.config/Code/User/*.json; do
    [ -e "$f" ] || continue
    ln -snf "$f" "$HOME/Library/Application Support/Code/User/"
  done

  cp "$DOTFILES/R/.R/Makevars-Darwin" "$HOME/.R/Makevars"

elif [ "$distro" = "Linux" ]; then
  mkdir -p "$HOME/.R"
  cp "$DOTFILES/R/.R/Makevars-Linux" "$HOME/.R/Makevars"
fi

echo "stow done"
