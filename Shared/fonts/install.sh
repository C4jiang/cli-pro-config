#!/usr/bin/env bash

# Font Installer Script
# Installs JetBrainsMonoNerdFont-Regular.ttf to the current OS's font directory.

FONT_FILE="JetBrainsMonoNerdFont-Regular.ttf"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FONT_PATH="$DIR/$FONT_FILE"

if [ ! -f "$FONT_PATH" ]; then
    echo "Error: Font file $FONT_FILE not found in $DIR!"
    exit 1
fi

echo "Detecting Operating System..."

# Detect OS
OS_TYPE="$(uname -s)"

case "$OS_TYPE" in
    Darwin)
        echo "Detected macOS."
        TARGET_DIR="$HOME/Library/Fonts"
        mkdir -p "$TARGET_DIR"
        echo "Copying $FONT_FILE to $TARGET_DIR..."
        cp "$FONT_PATH" "$TARGET_DIR/"
        echo "Font successfully installed to macOS!"
        ;;
    Linux)
        echo "Detected Linux."
        TARGET_DIR="$HOME/.local/share/fonts"
        mkdir -p "$TARGET_DIR"
        echo "Copying $FONT_FILE to $TARGET_DIR..."
        cp "$FONT_PATH" "$TARGET_DIR/"
        echo "Refreshing system font cache..."
        if command -v fc-cache >/dev/null 2>&1; then
            fc-cache -f
            echo "Font cache refreshed successfully."
        else
            echo "Warning: 'fc-cache' not found. Please refresh your font cache manually if needed."
        fi
        echo "Font successfully installed to Linux!"
        ;;
    *)
        echo "Unsupported OS type: $OS_TYPE"
        echo "If you are on Windows:"
        echo "1. Open the 'Shared/fonts/' folder in File Explorer."
        echo "2. Double-click '$FONT_FILE'."
        echo "3. Click the 'Install' button."
        exit 1
        ;;
esac
