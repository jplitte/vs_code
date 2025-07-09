# VSCode Backup

This repository helps you back up and restore VSCode settings, keybindings, snippets, and installed extensions across macOS, Linux, and Windows.

---

## 🔄 Backup

Run the following script to back up your current VSCode configuration:

```bash
./backup.sh
```

This backs up:
- `settings.json`
- `keybindings.json`
- All user snippets
- List of installed extensions → `vscode-extensions.txt`

Backed up files are stored in the `User/` folder.

---

## ♻️ Restore on a New Machine

To restore your VSCode configuration on a new system:

```bash
./restore.sh
```

Make sure the `code` CLI is available on your path.

> 💡 To enable the `code` command from VSCode:  
> Open VSCode → Press `Ctrl+Shift+P` → Run:  
> `Shell Command: Install 'code' command in PATH`

---

## ✅ OS Compatibility

| OS        | Supported? | Notes |
|-----------|------------|-------|
| macOS     | ✅         | `$HOME/Library/Application Support/Code/User` |
| Linux     | ✅         | `$HOME/.config/Code/User` |
| Windows   | ✅         | Uses `$APPDATA/Code/User` (compatible with Git Bash or WSL) |

---

## 📁 What Gets Backed Up

| File/Folder            | Description                             |
|------------------------|-----------------------------------------|
| `User/settings.json`   | Global VSCode editor settings            |
| `User/keybindings.json`| Custom keybindings                      |
| `User/snippets/`       | All user-defined code snippets          |
| `vscode-extensions.txt`| List of all installed extensions        |

---

## 📦 Setup with GitHub

To track and sync your config across machines, set up a Git repo:

```bash
git init
git add .
git commit -m "Initial VSCode backup"
gh repo create vscode-backup --private --source=. --remote=origin --push
```

> Requires the [GitHub CLI](https://cli.github.com/)

---

## 🛠 Tips

- Consider automating backups with a cron job (Linux/macOS) or Task Scheduler (Windows).
- Always ensure VSCode is closed before restoring settings to avoid overwrites.
- Run backup regularly, especially after major customization or extension changes.

---

## 🔐 Optional: Encrypt Settings Before Upload

If you're backing up sensitive snippets or settings, consider encrypting the backup with `gpg`:

```bash
tar czf - User/ vscode-extensions.txt | gpg -c > vscode-backup.tar.gz.gpg
```

Then commit the `.gpg` file instead of the raw data.

---
