#!/bin/bash

source "./git_common.sh"


# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Find the root of the Git repository
REPO_DIR=$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel 2>/dev/null)

# Navigate to the repository
cd "$REPO_DIR" || exit 1

# Create a cron_logs folder
mkdir -p "$REPO_DIR"/cron_logs

# Check for changes
if  check_uncommitted_changes ; then
    auto_commit_and_push "$@"
fi


# Rotate logs (keep last 14 days)
find "$HOME"/.dotfiles/cron_logs -name "auto_commit.log*" -mtime +14 -delete
