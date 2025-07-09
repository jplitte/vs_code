#!/bin/bash

set -e

echo "♻️ Restoring VSCode settings..."

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
SRC_DIR="./User"

mkdir -p "$VSCODE_USER_PATH/snippets"

# Copy files
cp "$SRC_DIR/settings.json" "$VSCODE_USER_PATH/settings.json" 2>/dev/null || echo "⚠️ settings.json missing"
cp "$SRC_DIR/keybindings.json" "$VSCODE_USER_PATH/keybindings.json" 2>/dev/null || echo "⚠️ keybindings.json missing"
cp "$SRC_DIR/snippets/"* "$VSCODE_USER_PATH/snippets/" 2>/dev/null || echo "⚠️ snippets missing"

# Reinstall extensions
if [ -f vscode-extensions.txt ]; then
    if command -v code >/dev/null 2>&1; then
        echo "📦 Reinstalling extensions..."
        xargs -n1 code --install-extension < vscode-extensions.txt
    else
        echo "❌ 'code' CLI not found. Skipping extensions restore."
    fi
else
    echo "⚠️ vscode-extensions.txt not found."
fi

echo "✅ Restore complete."
