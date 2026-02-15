# Dotfiles

Personal configuration files for macOS development environment.

## What's Included

- **Neovim** - Editor configuration with lazy.nvim
- **tmux** - Terminal multiplexer with Tokyo Night theme
- **Ghostty** - Terminal emulator configuration

## Installation

```bash
cd ~/.config
./install.sh
```

The install script will:
- Create symlinks for tmux config to `~/.tmux.conf`
- Create symlink for Ghostty config to `~/Library/Application Support/com.mitchellh.ghostty/config`
- Skip nvim (already in the correct location at `~/.config/nvim`)

## Post-Installation

### tmux

Install TPM (Tmux Plugin Manager):
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then in tmux, press `Ctrl+s` + `I` (capital i) to install plugins.

### tmux Key Bindings

- **Prefix**: `Ctrl+s`
- **Reload config**: `Ctrl+s` + `r`
- **Split horizontal**: `Ctrl+s` + `|`
- **Split vertical**: `Ctrl+s` + `-`
- **Navigate panes**: `Ctrl+h/j/k/l` or `Alt+Arrow`
- **Switch windows**: `Shift+Arrow` or `Alt+H/L`
- **Resize panes**: `Ctrl+s` + `H/J/K/L`

### Ghostty

- Reload config: `Cmd+Shift+,`
- Polish characters: Use **Right Option** + letter (e.g., Right Option+a = ą)
- Left Option works as Alt for terminal shortcuts

## Theme

Using Tokyo Night theme across all tools:
- tmux: Storm variation with colorful widgets
- Neovim: Custom configuration
- Ghostty: Transparency with blur effect

## Widget Colors

- DateTime: Yellow
- Battery: Green
- CPU: Red
- Memory: Magenta
- Network: Cyan
- Weather: Blue
- Now Playing: Magenta

## Requirements

- macOS
- Git
- Neovim >= 0.9.0
- tmux
- Ghostty
- Nerd Font (MesloLGS recommended)

## Updating

```bash
cd ~/.config
git pull
```

Then reload affected applications (tmux: `Ctrl+s` + `r`, Ghostty: `Cmd+Shift+,`)
