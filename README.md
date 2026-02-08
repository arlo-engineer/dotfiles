# dotfiles

A repository for managing development environment configuration files.
Each config file is placed at its expected path via symlinks.

## Managed Files

| File             | Symlink                    |
| ---------------- | -------------------------- |
| `ghostty/config` | `~/.config/ghostty/config` |
| `zsh/.zshrc`     | `~/.zshrc`                 |

## Setup

### 1. Clone the repository

```bash
git clone git@github.com:arlo-engineer/dotfiles.git ~/dotfiles
```

### 2. Create symlinks

```bash
# Ghostty
mkdir -p ~/.config/ghostty
ln -s ~/dev/personal/dotfiles/ghostty/config ~/.config/ghostty/config
```

If a file already exists, back it up and remove it before creating the symlink.

```bash
# Example: replace .zshrc
cp ~/.zshrc ~/.zshrc.bak
rm ~/.zshrc
ln -s ~/dev/personal/dotfiles/zsh/.zshrc ~/.zshrc
```

### 3. Verify symlinks

```bash
ls -la ~/.zshrc
ls -la ~/.config/ghostty/config
```

The output should show `->` followed by the path inside the dotfiles repository.

## Adding a New Config File

```bash
# 1. Copy the config file into the repository
mkdir -p ~/dotfiles/<tool-name>
cp <original-path> ~/dotfiles/<tool-name>/<filename>

# 2. Remove the original and create a symlink
rm <original-path>
ln -s ~/dev/personal/dotfiles/<tool-name>/<filename> <original-path>

# 3. Commit and push
cd ~/dotfiles
git add .
git commit -m "add <tool-name> config"
git push
```

## Notes

- Never commit secrets such as private keys, API keys, or tokens
- If managing `.ssh/config`, use a template with placeholder values for hosts and IPs
- Always confirm the copy is complete before running `rm`
