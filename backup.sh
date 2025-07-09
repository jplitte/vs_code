#!/bin/bash

set -e

echo "🔄 Backing up VSCode settings..."

# Detect OS and set VSCode user path
detect_vscode_user_path() {
    case "$OSTYPE" in
        darwin*) echo "$HOME/Library/Application Support/Code/User" ;;
        linux*) echo "$HOME/.config/Code/User" ;;
        msys*|cygwin*) echo "$APPDATA/Code/User" ;;
        *) echo "❌ Unsupported OS: $OSTYPE" && exit 1 ;;
    esac
}

VSCODE_USER_PATH=$(detect_vscode_user_path)
DEST_DIR="./User"

mkdir -p "$DEST_DIR/snippets"

# Copy settings
cp "$VSCODE_USER_PATH/settings.json" "$DEST_DIR/settings.json" 2>/dev/null || echo "⚠️ No settings.json found"
cp "$VSCODE_USER_PATH/keybindings.json" "$DEST_DIR/keybindings.json" 2>/dev/null || echo "⚠️ No keybindings.json found"
cp "$VSCODE_USER_PATH/snippets/"* "$DEST_DIR/snippets/" 2>/dev/null || echo "⚠️ No snippets found"

# Save extension list
if command -v code >/dev/null 2>&1; then
    code --list-extensions > vscode-extensions.txt
else
    echo "❌ 'code' CLI not found. Skipping extensions backup."
fi

echo "✅ Backup complete."
