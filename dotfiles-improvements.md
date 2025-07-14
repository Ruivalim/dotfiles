# Dotfiles Improvement Suggestions

## CLI Tools to Add

### Essential Replacements
- **bat** - Better `cat` with syntax highlighting and git integration
- **ripgrep (rg)** - Blazing fast search tool, pairs perfectly with fzf
- **fd** - Modern `find` replacement with intuitive syntax
- **eza** - Modern `ls` replacement (you already have lsd, but eza is more feature-rich)
- **zoxide** - Smart `cd` with frecency (learns your most used directories)

### Development & Productivity
- **lazygit** - Beautiful TUI for git operations
- **btop** - Modern system monitor (better than htop)
- **dust** - Disk usage analyzer with tree view
- **httpie** - User-friendly HTTP client for API testing
- **jq** - Command-line JSON processor
- **yq** - YAML/XML processor (like jq but for YAML)
- **gh** - GitHub CLI for managing repos, PRs, issues
- **delta** - Better git diff viewer with syntax highlighting

### System Tools
- **procs** - Modern `ps` replacement
- **bandwhich** - Network utilization monitor
- **bottom** - Alternative system monitor
- **tokei** - Code statistics tool
- **hyperfine** - Command-line benchmarking tool

## Neovim Plugin Suggestions

### Missing Essential Plugins
- **nvim-dap** - Debug Adapter Protocol support
- **nvim-dap-ui** - UI for the debugger
- **trouble.nvim** - Pretty diagnostics list
- **harpoon** - Quick file navigation
- **undotree** - Visualize undo history (alternative to mundo)
- **vim-fugitive** - Advanced Git integration
- **diffview.nvim** - Enhanced diff viewing

### GitHub Integration
- **octo.nvim** - GitHub integration (issues, PRs, reviews)
- **gh.nvim** - GitHub CLI integration
- **gitlinker.nvim** - Generate permalinks to Git hosting sites

### Database Tools (if needed)
- **vim-dadbod** - Database interface
- **vim-dadbod-ui** - UI for vim-dadbod
- **vim-dadbod-completion** - Completion for SQL

### Additional Productivity
- **aerial.nvim** - Code outline window
- **symbols-outline.nvim** - Alternative code outline
- **todo-comments.nvim** - Highlight and search TODO comments
- **neogen** - Annotation generator (docstrings, etc.)

## Hyprland Ecosystem Enhancements

### Screenshot & Screen Recording
- **grim** - Screenshot utility for Wayland
- **slurp** - Screen area selection for Wayland
- **swappy** - Screenshot editing tool
- **wf-recorder** - Screen recording for Wayland

### Clipboard & File Management
- **wl-clipboard** - Clipboard utilities for Wayland
- **cliphist** - Clipboard history manager
- **thunar** or **dolphin** - GUI file manager (if needed)

### System Management
- **swayidle** - Idle management daemon
- **swaylock** - Screen locker (alternative to hyprlock)
- **kanshi** - Dynamic display configuration
- **gammastep** - Blue light filter

### Audio & Media
- **pwvucontrol** - PipeWire volume control GUI
- **playerctl** - Media player controller

## Terminal & Shell Improvements

### ZSH Plugins to Consider
- **zsh-syntax-highlighting** - Command syntax highlighting
- **zsh-history-substring-search** - Fish-like history search
- **zsh-completions** - Additional completion definitions
- **fast-syntax-highlighting** - Faster alternative to zsh-syntax-highlighting

### Terminal Alternatives
- **alacritty** - GPU-accelerated terminal (lighter than ghostty)
- **foot** - Lightweight Wayland terminal
- **kitty** - Feature-rich terminal with image support

## Package Managers & Tools

### Language-Specific Tools
- **rustup** - Rust toolchain manager
- **pyenv** - Python version manager
- **rbenv** - Ruby version manager
- **gvm** - Go version manager

### Universal Package Managers
- **homebrew** - Package manager for macOS/Linux
- **nix** - Functional package manager
- **flatpak** - Application distribution framework

## Monitoring & System Info

### System Information
- **neofetch** or **fastfetch** - System information display
- **onefetch** - Git repository information
- **cpufetch** - CPU information display

### Network Tools
- **dog** - Modern `dig` replacement
- **gping** - Ping with graph
- **rustscan** - Fast port scanner

## Notes & Documentation

### Note-Taking Systems
- **obsidian** - Knowledge management system
- **logseq** - Block-based note-taking
- **zk** - Plain text note-taking assistant

### Documentation Tools
- **tldr** - Simplified man pages
- **cheat** - Create and view interactive cheatsheets
- **navi** - Interactive cheatsheet tool

## Installation Priority

### High Priority (Essential)
1. bat, ripgrep, fd, zoxide
2. lazygit, gh
3. grim, slurp, wl-clipboard
4. btop, dust

### Medium Priority (Quality of Life)
1. delta, httpie, jq
2. swayidle, cliphist
3. trouble.nvim, harpoon
4. procs, bandwhich

### Low Priority (Nice to Have)
1. hyperfine, tokei
2. neofetch, tldr
3. Additional nvim plugins based on workflow needs