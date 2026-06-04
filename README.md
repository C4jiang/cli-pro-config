# cli-pro-config (CLI Config)

A portable backup of my current CLI environment, focused on config-first recovery for Neovim, Yazi, tmux, and Shell/Git Chinese support.

这份仓库保存了当前可迁移的 CLI 配置。目标不是机械复制整台机器，而是提供一份更适合 Git 保存、也更适合让 agent 在新设备上恢复的配置源。

## Included (包含内容)

### Neovim
- `nvim/config/init.lua`: Main config (Maintained at 4-space indentation).
- `nvim/config/lazy-lock.json`: Plugin lockfile.
- `nvim/plugins-lazy/`: Plugin source snapshots.

### Yazi
- `yazi/config/*.toml`: Keymaps, theme, and general config.
- `yazi/config/init.lua`: Yazi initialization script.
- `yazi/plugins/`: Custom Yazi plugins.

### tmux
- `tmux/config/.tmux.conf`: Tmux configuration.
- `tmux/plugins/`: TPM and plugins.

### Shell & Git (Chinese Support / 中文支持)
- `zsh/locale.zsh`: Locale environment variables for Chinese support.
- `git/config`: Git core settings (e.g., `quotepath = false`) for Chinese filename display.

---

## Not included (不包含内容)

To keep the repo cleaner and more portable, these were intentionally removed:
- `nvim/mason-packages/`: Too large and machine-specific; reinstall on target.
- Duplicate copy of `yazi/config/plugins/`: `yazi/plugins/` is the canonical source.

## Restore philosophy (恢复原则)

This repo is a practical, agent-friendly recovery source:
- Keep config & lockfiles.
- Keep plugin source snapshots when useful.
- Avoid bulky, machine-specific runtime payloads.

---

## Recommended base dependencies (推荐基础依赖)

On macOS with Homebrew:

```bash
brew install neovim tmux yazi git ripgrep fd fzf lua-language-server ruff
npm install -g pyright
```

## Restore overview (恢复步骤)

### Neovim
```bash
mkdir -p ~/.config/nvim
cp -R ./nvim/config/. ~/.config/nvim/

mkdir -p ~/.local/share/nvim/lazy
cp -R ./nvim/plugins-lazy/. ~/.local/share/nvim/lazy/
# Then run nvim and sync: :Lazy sync, :Mason, :TSUpdate
```

### Yazi
```bash
mkdir -p ~/.config/yazi
cp -R ./yazi/config/. ~/.config/yazi/

mkdir -p ~/.config/yazi/plugins
cp -R ./yazi/plugins/. ~/.config/yazi/plugins/
```

### tmux
```bash
cp ./tmux/config/.tmux.conf ~/.tmux.conf
mkdir -p ~/.tmux/plugins
cp -R ./tmux/plugins/. ~/.tmux/plugins/
# Inside tmux: Ctrl-b I
```

### Shell & Git (Chinese Support)
```bash
# Apply locale settings to zsh
cat ./zsh/locale.zsh >> ~/.zshrc

# Apply git settings
git config --global core.quotepath false
```

---

## Notes
- `how-to-use.md` documents usage and keybindings.
- This repo is suitable for Git-based storage and agent-driven installation.
