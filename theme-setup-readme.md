# Unified Theme System

This is a unified theming system for your desktop environment that allows you to easily switch themes across all applications.

## Supported Applications

- **Ghostty** (terminal)
- **Waybar** (status bar)
- **Wofi** (application launcher)
- **Dunst** (notification daemon)
- **Hyprland** (window manager borders and decorations)

## Available Themes

- **rose-pine** (default) - Based on the Rose Pine color palette
- **gruvbox** - Based on the classic Gruvbox Dark theme

## Quick Start

1. **Apply default theme (Rose Pine):**
   ```bash
   ~/.config/themes/apply-theme.sh
   ```

2. **Apply specific theme:**
   ```bash
   ~/.config/themes/apply-theme.sh gruvbox
   ```

3. **List available themes:**
   ```bash
   ~/.config/themes/apply-theme.sh --list
   ```

## Script Options

- `--list` or `-l` - List available themes
- `--help` or `-h` - Show help information
- `--no-backup` - Skip creating backup of current configs
- `--no-reload` - Skip reloading applications after applying theme

## How It Works

The system uses:
- **Theme files** (`.theme`) containing color definitions
- **Templates** (`.tmpl`) for each application's config format
- **Apply script** that processes templates and applies changes

### Theme Structure

```
~/.config/themes/
├── rose-pine.theme          # Theme color definitions
├── gruvbox.theme           # Another theme
├── apply-theme.sh          # Main script
└── templates/              # Config templates
    ├── ghostty.tmpl
    ├── waybar.tmpl
    ├── wofi.tmpl
    ├── dunst.tmpl
    └── hyprland.tmpl
```

## Creating Custom Themes

1. **Create a new theme file** (e.g., `~/.config/themes/catppuccin.theme`):
   ```bash
   # Catppuccin Mocha Theme
   BASE="#1e1e2e"
   SURFACE="#313244"
   TEXT="#cdd6f4"
   # ... define all required colors
   ```

2. **Follow the variable naming convention** from existing themes

3. **Test your theme:**
   ```bash
   ~/.config/themes/apply-theme.sh catppuccin
   ```

## Automatic Backups

Before applying any theme, the script automatically creates backups of your current configurations in:
```
~/.config/themes/backups/YYYYMMDD_HHMMSS/
```

## Manual Steps

Some applications may need manual action after theme application:

- **Hyprland**: Run `hyprctl reload` to apply border color changes
- **Ghostty**: Restart terminal windows to see changes
- **New applications**: Will automatically use the new theme

## Troubleshooting

1. **Script permission error:**
   ```bash
   chmod +x ~/.config/themes/apply-theme.sh
   ```

2. **Theme not found:**
   - Check theme file exists in `~/.config/themes/`
   - Use `--list` to see available themes

3. **App not reloading:**
   - Try restarting the application manually
   - Check if the process is actually running

## Integration with Chezmoi

This theme system is designed to work with chezmoi dotfiles management. After applying themes, run:
```bash
chezmoi add ~/.config/ghostty/config
chezmoi add ~/.config/waybar/style.css
chezmoi add ~/.config/wofi/style.css
chezmoi add ~/.config/dunst/dunstrc
# etc.
```

To track changes in your dotfiles repository.