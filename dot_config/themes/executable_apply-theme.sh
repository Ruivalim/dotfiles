#!/bin/bash

# Theme switcher script for unified theming
# Usage: ./apply-theme.sh [theme-name]
# Default theme: rose-pine

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEMES_DIR="$SCRIPT_DIR"
TEMPLATES_DIR="$SCRIPT_DIR/templates"
CONFIG_DIR="$HOME/.config"

# Default theme
THEME_NAME="${1:-rose-pine}"
THEME_FILE="$THEMES_DIR/$THEME_NAME.theme"

# Function to show available themes
show_themes() {
    echo "Available themes:"
    for theme in "$THEMES_DIR"/*.theme; do
        if [[ -f "$theme" ]]; then
            basename "$theme" .theme
        fi
    done
}

# Function to backup current configs
backup_configs() {
    local backup_dir="$CONFIG_DIR/themes/backups/$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    echo "Creating backup in: $backup_dir"
    
    # Backup current configs
    [[ -f "$CONFIG_DIR/ghostty/config" ]] && cp "$CONFIG_DIR/ghostty/config" "$backup_dir/ghostty.config"
    [[ -f "$CONFIG_DIR/waybar/style.css" ]] && cp "$CONFIG_DIR/waybar/style.css" "$backup_dir/waybar.style.css"
    [[ -f "$CONFIG_DIR/wofi/style.css" ]] && cp "$CONFIG_DIR/wofi/style.css" "$backup_dir/wofi.style.css"
    [[ -f "$CONFIG_DIR/dunst/dunstrc" ]] && cp "$CONFIG_DIR/dunst/dunstrc" "$backup_dir/dunstrc"
}

# Function to apply theme to a specific app
apply_app_theme() {
    local app="$1"
    local template_file="$TEMPLATES_DIR/$app.tmpl"
    local output_file=""
    
    case "$app" in
        "ghostty")
            output_file="$CONFIG_DIR/ghostty/config"
            ;;
        "waybar")
            output_file="$CONFIG_DIR/waybar/style.css"
            ;;
        "wofi")
            output_file="$CONFIG_DIR/wofi/style.css"
            ;;
        "dunst")
            output_file="$CONFIG_DIR/dunst/dunstrc"
            ;;
        "hyprland")
            output_file="$CONFIG_DIR/hypr/theme.conf"
            ;;
        "nvim")
            output_file="$CONFIG_DIR/nvim/lua/theme.lua"
            ;;
        *)
            echo "Unknown app: $app"
            return 1
            ;;
    esac
    
    if [[ ! -f "$template_file" ]]; then
        echo "Template not found: $template_file"
        return 1
    fi
    
    # Create output directory if it doesn't exist
    mkdir -p "$(dirname "$output_file")"
    
    # Process template with theme variables
    local content
    content=$(cat "$template_file")
    
    # Replace all template variables
    while IFS='=' read -r key value; do
        # Skip comments and empty lines
        [[ "$key" =~ ^#.*$ ]] || [[ -z "$key" ]] && continue
        
        # Remove quotes from value if present
        value="${value#\"}"
        value="${value%\"}"
        
        # Replace template placeholders
        content="${content//\{\{$key\}\}/$value}"
    done < "$THEME_FILE"
    
    # Write processed content to output file
    echo "$content" > "$output_file"
    echo "Applied $THEME_NAME theme to $app -> $output_file"
}

# Function to reload applications
reload_apps() {
    echo "Reloading applications..."
    
    # Reload waybar
    if pgrep -x waybar > /dev/null; then
        pkill waybar
        sleep 1
        waybar &
        echo "Reloaded waybar"
    fi
    
    # Reload dunst
    if pgrep -x dunst > /dev/null; then
        pkill dunst
        sleep 1
        dunst &
        echo "Reloaded dunst"
    fi
    
    # Hyprland needs manual reload or restart
    if [[ -f "$CONFIG_DIR/hypr/theme.conf" ]]; then
        echo "Hyprland theme updated. You may need to reload Hyprland config manually:"
        echo "  hyprctl reload"
    fi
    
    echo "Note: Ghostty terminal will use new theme on next launch"
}

# Main script
main() {
    case "$1" in
        "--list"|"-l")
            show_themes
            exit 0
            ;;
        "--help"|"-h")
            echo "Usage: $0 [theme-name] [options]"
            echo ""
            echo "Options:"
            echo "  -l, --list     List available themes"
            echo "  -h, --help     Show this help"
            echo "  --no-backup    Skip creating backup"
            echo "  --no-reload    Skip reloading applications"
            echo ""
            echo "Examples:"
            echo "  $0                  # Apply default theme (rose-pine)"
            echo "  $0 gruvbox          # Apply gruvbox theme"
            echo "  $0 rose-pine --no-reload"
            exit 0
            ;;
    esac
    
    # Check if theme file exists
    if [[ ! -f "$THEME_FILE" ]]; then
        echo "Theme file not found: $THEME_FILE"
        echo ""
        show_themes
        exit 1
    fi
    
    echo "Applying theme: $THEME_NAME"
    
    # Create backup unless --no-backup is specified
    if [[ "$*" != *"--no-backup"* ]]; then
        backup_configs
    fi
    
    # Source theme file to load variables
    source "$THEME_FILE"
    
    # Set OS-specific variables - dynamically find zsh
    ZSH_PATH=$(which zsh 2>/dev/null || echo "/bin/zsh")
    ZSH_COMMAND="command = $ZSH_PATH --login --interactive"
    
    # Apply theme to all applications
    apply_app_theme "ghostty"
    apply_app_theme "waybar"
    apply_app_theme "wofi"
    apply_app_theme "dunst"
    apply_app_theme "hyprland"
    apply_app_theme "nvim"
    
    # Reload applications unless --no-reload is specified
    if [[ "$*" != *"--no-reload"* ]]; then
        reload_apps
    fi
    
    echo ""
    echo "Theme '$THEME_NAME' applied successfully!"
    echo "Some applications may require a restart to see changes."
}

main "$@"