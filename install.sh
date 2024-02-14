#!/bin/sh
set -e

# Ensure stow is installed
command -v stow >/dev/null 2>&1 || { echo "stow command not found. Exiting."; exit 1; }

DOT_DIRECTORY="${HOME}/dotfiles"

# Iterate over directories and use stow to manage symlinks
for dir in "$DOT_DIRECTORY"/*/; do
    dir_base=$(basename "$dir")

    case "$dir_base" in
        tests|deps|fonts) continue ;;  # Skip these directories
        *) ;;
    esac

    echo "~ Installing :: $dir_base"
    # Remove previous links
    stow -D --dotfiles --dir "$DOT_DIRECTORY" --target "$HOME" "$dir_base" 2>/dev/null || true
    # Install new links
    stow --dotfiles --dir "$DOT_DIRECTORY" --target "$HOME" "$dir_base"
    echo "done: $dir_base"
done
