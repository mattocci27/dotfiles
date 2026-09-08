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

stow_package() {
    package="$1"
    shift

    if [ "$package" = "zed" ]; then
        stow --ignore='(^|/)(settings\.json|sync-settings\.sh)$' "$@" "$package"
    else
        stow "$@" "$package"
    fi
}

# Iterate over directories and use stow to manage symlinks
for dir in "$DOT_DIRECTORY"/*/; do
    dir_base=$(basename "$dir")

    case "$dir_base" in
        tests|deps|fonts|agent-skills) continue ;;  # Skip these directories
        *) ;;
    esac

    echo "~ Installing :: $dir_base"

    # Check for potential conflicts before removing
    stow_package "$dir_base" --dir "$DOT_DIRECTORY" --target "$HOME" --no 2>/dev/null | grep "^LINK:" | awk '{print $2}' | while read -r file; do
        backup_and_remove_conflict "$HOME/$file"
    done

    # Remove previous symlinks
    stow_package "$dir_base" -D --dir "$DOT_DIRECTORY" --target "$HOME" 2>/dev/null || true
    # Install new symlinks
    stow_package "$dir_base" --dir "$DOT_DIRECTORY" --target "$HOME"
    echo "done: $dir_base"
done

# Link shared agent skills for both Codex and Claude Code.
for skill_dir in "$DOT_DIRECTORY"/agent-skills/*/; do
    [ -d "$skill_dir" ] || continue

    skill_dir=${skill_dir%/}
    skill_name=$(basename "$skill_dir")

    for skills_dir in "$HOME/.agents/skills" "$HOME/.claude/skills"; do
        mkdir -p "$skills_dir"
        ln -sfn "$skill_dir" "$skills_dir/$skill_name"
    done
done
