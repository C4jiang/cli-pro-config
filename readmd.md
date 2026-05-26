# CLI Config

这份目录保存了这台机器当前可用的三套 CLI 环境配置：

- Neovim
- Yazi
- tmux

目标是让你在别的设备上冷启动时，几乎直接恢复到当前体验。

## 目录结构

```text
cli-config/
├── nvim/
│   ├── config/           # ~/.config/nvim
│   ├── plugins-lazy/     # ~/.local/share/nvim/lazy
│   └── mason-packages/   # ~/.local/share/nvim/mason/packages
├── yazi/
│   ├── config/           # ~/.config/yazi
│   └── plugins/          # ~/.config/yazi/plugins
├── tmux/
│   ├── config/           # ~/.tmux.conf
│   └── plugins/          # ~/.tmux/plugins
├── readmd.md
└── how-to-use.md
```

## 这份备份包含什么

### Neovim

- 主配置：`init.lua`
- 插件锁定文件：`lazy-lock.json`
- 已下载的 lazy.nvim 插件目录
- Mason 已安装语言工具

当前插件主要包括：

- catppuccin
- lualine
- neo-tree
- which-key
- telescope
- treesitter
- nvim-lspconfig
- mason
- nvim-cmp
- luasnip
- gitsigns

当前 Mason 包包括：

- lua-language-server
- pyright
- ruff

### Yazi

- `yazi.toml`
- `theme.toml`
- `keymap.toml`
- `package.toml`
- `init.lua`
- 已装插件源码

当前插件包括：

- smart-enter
- git
- full-border
- bunny

### tmux

- `.tmux.conf`
- TPM 插件目录

当前插件包括：

- tpm
- tmux-resurrect
- tmux-continuum

## 新设备安装建议

建议系统先安装这些基础工具：

```bash
brew install neovim tmux yazi git ripgrep fd fzf lua-language-server
npm install -g pyright
brew install ruff
```

如果不是 macOS，请自行换成对应包管理器。

## 恢复步骤

### 1. 恢复 Neovim

```bash
mkdir -p ~/.config/nvim
cp -R ./nvim/config/. ~/.config/nvim/

mkdir -p ~/.local/share/nvim/lazy
cp -R ./nvim/plugins-lazy/. ~/.local/share/nvim/lazy/

mkdir -p ~/.local/share/nvim/mason/packages
cp -R ./nvim/mason-packages/. ~/.local/share/nvim/mason/packages/
```

然后执行：

```bash
nvim
```

如果有缺失，再执行：

```vim
:Lazy sync
:Mason
:TSUpdate
```

### 2. 恢复 Yazi

```bash
mkdir -p ~/.config/yazi
cp -R ./yazi/config/. ~/.config/yazi/
```

如需插件源码一起恢复：

```bash
mkdir -p ~/.config/yazi/plugins
cp -R ./yazi/plugins/. ~/.config/yazi/plugins/
```

然后执行：

```bash
yazi
```

### 3. 恢复 tmux

```bash
cp ./tmux/config/.tmux.conf ~/.tmux.conf
mkdir -p ~/.tmux/plugins
cp -R ./tmux/plugins/. ~/.tmux/plugins/
```

然后启动 tmux：

```bash
tmux
```

如果 TPM 没自动工作，可以在 tmux 里按：

```text
prefix + I
```

默认 prefix 是 `Ctrl-b`。

## 更稳妥的同步思路

如果你之后想长期维护，建议把这里变成 Git 仓库，然后：

- 配置文件纳入版本控制
- 插件目录可保留，也可只保留锁定文件
- 新设备优先恢复配置，再重新安装插件

## 备注

这份目录偏向“可直接拷贝恢复”，而不是最极致精简。

也就是说，它更像一份当前机器状态快照，适合：

- 迁移到新电脑
- 备份当前 CLI 工作环境
- 学习自己到底配了什么
