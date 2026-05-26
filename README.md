# cli-pro-config

A portable backup of my current CLI environment, focused on config-first recovery for:

- Neovim
- Yazi
- tmux

This repo is intended to be easy for another agent or a future machine to restore from. It keeps the important configuration and lock information, while avoiding unnecessary machine-specific runtime payloads.

## Included

### Neovim

- `nvim/config/init.lua`
- `nvim/config/lazy-lock.json`
- `nvim/plugins-lazy/`

### Yazi

- `yazi/config/*.toml`
- `yazi/config/init.lua`
- `yazi/plugins/`

### tmux

- `tmux/config/.tmux.conf`
- `tmux/plugins/`

## Not included

To keep the repo cleaner and more portable, these were intentionally removed:

- `nvim/mason-packages/`
  - too large and too machine/runtime specific
  - language servers and tools should be reinstalled on the target machine
- duplicate copy of `yazi/config/plugins/`
  - `yazi/plugins/` is the canonical plugin source snapshot

## Restore philosophy

This repo is not a byte-for-byte clone of one machine.
It is a practical, agent-friendly recovery source.

That means:

- keep config
- keep plugin source snapshots when useful
- keep lockfiles
- avoid bulky runtime environments that are better reinstalled

## Recommended base dependencies

On macOS with Homebrew:

```bash
brew install neovim tmux yazi git ripgrep fd fzf lua-language-server ruff
npm install -g pyright
```

## Restore overview

### Neovim

```bash
mkdir -p ~/.config/nvim
cp -R ./nvim/config/. ~/.config/nvim/

mkdir -p ~/.local/share/nvim/lazy
cp -R ./nvim/plugins-lazy/. ~/.local/share/nvim/lazy/
```

Then run:

```bash
nvim
```

If needed:

```vim
:Lazy sync
:Mason
:TSUpdate
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
```

Inside tmux, if needed:

```text
Ctrl-b I
```

## Notes

- `readmd.md` keeps the earlier Chinese explanation version.
- `how-to-use.md` documents usage and keybindings.
- This repo is suitable for Git-based storage and later agent-driven installation.
