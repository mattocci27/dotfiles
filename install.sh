#!/bin/sh
set -e

# Ensure stow is installed
command -v stow >/dev/null 2>&1 || { echo "stow command not found. Exiting."; exit 1; }

DOT_DIRECTORY="${HOME}/dotfiles"

# Function to handle conflicts
backup_and_remove_conflict() {
    local file="$1"
    local backup_dir="${HOME}/dotfiles_backup"

    mkdir -p "$backup_dir"

    if [ -f "$file" ] && [ ! -L "$file" ]; then
        echo "Backing up conflicting file: $file"
        mv "$file" "$backup_dir"
    fi
}

# Iterate over directories and use stow to manage symlinks
for dir in "$DOT_DIRECTORY"/*/; do
    dir_base=$(basename "$dir")

    case "$dir_base" in
        tests|deps|fonts) continue ;;  # Skip these directories
        *) ;;
    esac

    echo "~ Installing :: $dir_base"

    # Check for potential conflicts before removing
    stow --dir "$DOT_DIRECTORY" --target "$HOME" --no 2>/dev/null "$dir_base" | grep "^LINK:" | awk '{print $2}' | while read -r file; do
        backup_and_remove_conflict "$HOME/$file"
    done

    # Remove previous symlinks
    stow -D --dir "$DOT_DIRECTORY" --target "$HOME" "$dir_base" 2>/dev/null || true
    # Install new symlinks
    stow --dir "$DOT_DIRECTORY" --target "$HOME" "$dir_base"
    echo "done: $dir_base"
done
