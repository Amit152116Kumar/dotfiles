#!/bin/bash

# Simple SCP transfer script for Raspberry Pi
# Usage: ./transfer.sh [upload|download] [file/folder] [remote_path (optional)]

# Configuration
HOST="raspberrypi.local"  # Change if different
USER="pi"                 # Default Raspberry Pi user
DEFAULT_REMOTE_PATH="~/"  # Default remote directory

# Help function
show_help() {
    echo "Usage: $0 [upload|download] [file/folder] [remote_path (optional)]"
    echo "Examples:"
    echo "  Upload: ./transfer.sh upload myfile.txt ~/documents/"
    echo "  Download: ./transfer.sh download remote_file.txt ./local_folder/"
    exit 1
}

# Check minimum arguments
if [ $# -lt 2 ]; then
    show_help
fi

DIRECTION=$1
FILE=$2
REMOTE_PATH=${3:-$DEFAULT_REMOTE_PATH}

# Validate input
if [ ! -e "$FILE" ] && [ "$DIRECTION" == "upload" ]; then
    echo "Error: Local file/folder '$FILE' does not exist!"
    exit 2
fi

# Transfer functions
upload() {
    if [ -d "$FILE" ]; then
        scp -r "$FILE" "${USER}@${HOST}:${REMOTE_PATH}"
    else
        scp "$FILE" "${USER}@${HOST}:${REMOTE_PATH}"
    fi
}

download() {
    if [[ "$FILE" == */ ]]; then
        scp -r "${USER}@${HOST}:${FILE}" "$REMOTE_PATH"
    else
        scp "${USER}@${HOST}:${FILE}" "$REMOTE_PATH"
    fi
}

# Execute transfer
case $DIRECTION in
    upload|u)
        upload
        ;;
    download|d)
        download
        ;;
    *)
        echo "Invalid direction! Use 'upload' or 'download'"
        show_help
        ;;
esac

echo "Transfer completed successfully!"
