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

    # Check for potential conflicts before removing
    for file in $(stow --dir "$DOT_DIRECTORY" --target "$HOME"  "$dir_base" | grep "^LINK:" | awk '{print $2}'); do
        if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
            echo "Potential conflict: $HOME/$file already exists and is not a symlink"
        fi
    done

    # Remove previous symlinks
    stow -D --dir "$DOT_DIRECTORY" --target "$HOME" "$dir_base" 2>/dev/null || true
    # Install new symlinks
    stow --dir "$DOT_DIRECTORY" --target "$HOME" "$dir_base"
    echo "done: $dir_base"
done
