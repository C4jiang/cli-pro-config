# cli-pro-config (CLI Config)

A portable backup of my current CLI environment, focused on config-first recovery for Neovim, Yazi, tmux, and Shell/Git Chinese support.

这份仓库保存了当前可迁移的 CLI 配置。目标不是机械复制整台机器，而是提供一份更适合 Git 保存、也更适合让 agent 在新设备上恢复的配置源。

## Directory Structure & Included Contents (目录结构与包含内容)

This repository is organized by operating system and compatibility:

### 1. `Shared/` (通用配置)
Shared across Windows, Mac, and Linux:
- **Neovim** (`Shared/nvim/`): Common editor configuration (`init.lua`, `lazy-lock.json`) and plugin snapshots.
- **Yazi** (`Shared/yazi/`): Common file manager configurations (`yazi.toml`, keymap, theme) and custom plugins.
- **Git** (`Shared/git/config`): Universal Git base settings (`quotepath = false` for Chinese filename display).
- **Zsh** (`Shared/zsh/locale.zsh`): Shared shell locale settings (`LANG="en_US.UTF-8"`, `LC_ALL="en_US.UTF-8"`).

### 2. `Mac/` (macOS 专属)
- **tmux** (`Mac/tmux/`): Configuration with `copy-command 'pbcopy'` (specifically for Terminal.app compatibility) and its plugin ecosystem.

### 3. `Linux/` (Linux 专属)
- **tmux** (`Linux/tmux/`): Configuration with `copy-command 'xclip -selection clipboard'` for system clipboard access and its plugin ecosystem.

### 4. `Windows/` (Windows 专属)
- **Git** (`Windows/git/config`): Git settings optimized for Windows environments (e.g., `autocrlf = true`).

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

### 字体依赖与图标支持 (Font Dependency & Icons Support)

Yazi 图标的渲染依赖于 **Nerd Fonts**。若图标无法正常显示（显示为乱码或方块），我们提供了以下两种解决方案：

#### 方案一：安装 Nerd Font (推荐)
仓库已在 `Shared/fonts/` 目录下打包了常用的 **JetBrainsMono Nerd Font** 常规体（`JetBrainsMonoNerdFont-Regular.ttf`），并提供了一键安装脚本：
* **macOS / Linux**：
  ```bash
  bash ./Shared/fonts/install.sh
  ```
  安装完成后，请确保将终端模拟器（如 iTerm2, VS Code Terminal）的字体族设置为 `'JetBrainsMono Nerd Font'`。
* **Windows**：
  双击 `Shared/fonts/JetBrainsMonoNerdFont-Regular.ttf` 点击“安装”即可，然后在 Windows Terminal / VS Code 终端里选用该字体。

#### 方案二：使用 Emoji 降级配置 (针对 Terminal.app 等不支持图标的终端)
如果您当前使用的是 macOS 自带的 **Terminal.app**，即使安装了 Nerd Fonts 也可能由于渲染机制无法完美显示所有符号。为此，仓库中提供了一份 Emoji 降级主题配置文件：
* **恢复降级配置**：
  ```bash
  cp ./Shared/yazi/config/theme-emoji-fallback.toml ~/.config/yazi/theme.toml
  ```
  这会使用标准的 Emoji 符号（如 🌙 🐍 📁 📄）来展示文件类型，无需配置专门的 Nerd Font。



## Restore overview (恢复步骤)

### Neovim (Shared)
```bash
mkdir -p ~/.config/nvim
cp -R ./Shared/nvim/config/. ~/.config/nvim/

mkdir -p ~/.local/share/nvim/lazy
cp -R ./Shared/nvim/plugins-lazy/. ~/.local/share/nvim/lazy/
# Then run nvim and sync: :Lazy sync, :Mason, :TSUpdate
```

### Yazi (Shared)
```bash
mkdir -p ~/.config/yazi
cp -R ./Shared/yazi/config/. ~/.config/yazi/

mkdir -p ~/.config/yazi/plugins
cp -R ./Shared/yazi/plugins/. ~/.config/yazi/plugins/
```

### tmux (Mac / Linux)
Choose the source directory depending on your OS (replace `<OS>` with `Mac` or `Linux`):
```bash
cp ./<OS>/tmux/config/.tmux.conf ~/.tmux.conf
mkdir -p ~/.tmux/plugins
cp -R ./<OS>/tmux/plugins/. ~/.tmux/plugins/
# Inside tmux: Ctrl-b I (to install plugins)
```

### Shell & Git (Shared / Windows)
```bash
# Apply locale settings to zsh (macOS / Linux)
cat ./Shared/zsh/locale.zsh >> ~/.zshrc

# Apply universal git settings (macOS / Linux / Windows)
# For macOS / Linux:
cat ./Shared/git/config >> ~/.gitconfig
# For Windows (run in git bash / powershell):
# Apply Shared/git/config first, then Windows/git/config settings
```
```

---

## Notes
- `how-to-use.md` documents usage and keybindings.
- This repo is suitable for Git-based storage and agent-driven installation.
