# CLI Config

这份仓库保存了当前可迁移的三套 CLI 配置：

- Neovim
- Yazi
- tmux

目标不是机械复制整台机器，而是提供一份更适合 Git 保存、也更适合让 agent 在新设备上恢复的配置源。

## 当前目录结构

```text
cli-pro-config/
├── README.md
├── readmd.md
├── how-to-use.md
├── nvim/
│   ├── config/
│   │   ├── init.lua
│   │   └── lazy-lock.json
│   └── plugins-lazy/
├── yazi/
│   ├── config/
│   └── plugins/
└── tmux/
    ├── config/
    └── plugins/
```

## 本次整理后的原则

保留：

- 主要配置文件
- 插件源码快照
- 锁定文件
- 使用说明

移除：

- `nvim/mason-packages/`
  - 体积太大，而且偏运行时产物
  - 更适合在目标机器重新安装
- `yazi/config/plugins/`
  - 和 `yazi/plugins/` 重复，保留一份 canonical 版本即可

## 为什么这样更合理

如果要让之后的 agent 来安装，那么最重要的是：

- 看得懂结构
- 能确定配置内容
- 知道依赖和恢复步骤
- 不被机器相关的大型运行时垃圾干扰

所以现在这份仓库比原始快照更适合长期维护。

## 恢复思路

### Neovim

恢复配置和插件目录，然后让目标机器自己：

- `:Lazy sync`
- `:Mason`
- `:TSUpdate`

### Yazi

恢复配置和 `plugins/` 即可。

### tmux

恢复 `.tmux.conf` 和 TPM 插件目录即可。

## 建议

后面如果你还继续迭代它，比较适合再加：

- `Brewfile`
- `install.sh`
- `check-health.sh`

不过你刚才说之后安装让 agent 处理，那现在这样已经够作为配置源使用了。
