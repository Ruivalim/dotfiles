# Neovim Configuration for TypeScript/React/Tailwind Development

This Neovim configuration is optimized for modern web development with TypeScript, React, and Tailwind CSS.

## Key Features

### 🎯 Language Support
- **TypeScript/JavaScript**: Enhanced LSP with inlay hints, better error handling, and auto-imports
- **React/JSX**: Auto-tag closing, component extraction, styled-components support
- **Tailwind CSS**: IntelliSense, color previews, class validation, and conflict detection
- **CSS/SCSS**: Advanced styling support with color previews
- **HTML**: Emmet integration and auto-completion

### 🔍 Enhanced Diagnostics & Error Handling
- **Trouble.nvim**: Beautiful diagnostic list with quick navigation
- **LSP Lines**: Inline error messages below problematic code
- **Auto diagnostics**: Floating error messages on cursor hold
- **Enhanced signs**: Better visual indicators for errors, warnings, hints

### ⚡ Movement & Navigation
- **Flash.nvim**: Lightning-fast navigation with labels
- **Leap.nvim**: Powerful jump-to-anywhere functionality
- **Tmux integration**: Seamless navigation between vim splits and tmux panes
- **Enhanced window navigation**: Intuitive window switching and resizing

### 📝 Snippets & Completion
- **LuaSnip**: Powerful snippet engine with custom React/TypeScript snippets
- **Friendly snippets**: Comprehensive snippet collection
- **Enhanced nvim-cmp**: Intelligent auto-completion with multiple sources

### 🎨 UI & Visual Enhancements
- **Better diagnostics signs**: Clear visual indicators
- **Inlay hints**: Type information displayed inline
- **Color previews**: CSS colors shown directly in editor
- **Smooth cursor**: Visual cursor movement animations

## New Plugins Added

### Core Development Tools
- `luckasRanarison/tailwind-tools.nvim` - Tailwind CSS IntelliSense and tools
- `folke/trouble.nvim` - Diagnostic list and navigation
- `https://git.sr.ht/~whynothugo/lsp_lines.nvim` - Inline diagnostic messages

### Snippets & Completion
- `L3MON4D3/LuaSnip` - Snippet engine
- `rafamadriz/friendly-snippets` - Snippet collection
- `saadparwaiz1/cmp_luasnip` - LuaSnip source for nvim-cmp

### React & JSX Development
- `windwp/nvim-ts-autotag` - Auto-close and rename HTML/JSX tags
- `maxmellon/vim-jsx-pretty` - Better JSX syntax highlighting
- `styled-components/vim-styled-components` - Styled components support
- `David-Kunz/react-extract.nvim` - Extract React components

### Navigation & Movement
- `christoomey/vim-tmux-navigator` - Tmux integration
- `folke/flash.nvim` - Enhanced search and navigation (updated configuration)
- `ggandor/leap.nvim` - Jump-to-anywhere navigation

## Key Bindings

### Diagnostics & Errors
- `<leader>dd` - Show diagnostics in floating window
- `<leader>dt` - Toggle Trouble diagnostics list
- `<leader>dw` - Show workspace diagnostics
- `<leader>dr` - Show document diagnostics
- `<leader>dn/dp` - Next/Previous diagnostic

### TypeScript/React Specific
- `<leader>lo` - Organize imports
- `<leader>lR` - Rename file
- `<leader>li` - Add missing imports
- `<leader>lf` - Fix all issues
- `<leader>re` - Extract React component to file (visual mode)
- `<leader>rc` - Extract React component (visual mode)

### Snippets
- `<C-k>` - Expand or jump to next snippet placeholder
- `<C-j>` - Jump to previous snippet placeholder
- `<C-l>` - Cycle through choice nodes

### Navigation
- `s` - Flash jump (normal/visual/operator modes)
- `S` - Flash treesitter jump
- `<C-h/j/k/l>` - Navigate between windows/tmux panes
- `<A-j/k>` - Move lines up/down
- `<C-d/u>` - Scroll and center cursor

### Movement Enhancements
- `n/N` - Next/previous search result (centered)
- `<C-Up/Down/Left/Right>` - Resize windows
- `]q/[q` - Next/previous quickfix
- `]l/[l` - Next/previous location list

## Custom React/TypeScript Snippets

### TypeScript React
- `rfc` - React functional component with TypeScript interface
- `useState` - useState hook with TypeScript types
- `useEffect` - useEffect hook template

## LSP Servers Configured

- **TypeScript/JavaScript**: `ts_ls` with enhanced settings
- **Tailwind CSS**: `tailwindcss` with advanced class detection
- **CSS**: `cssls` and `css_variables`
- **HTML**: Enhanced with Emmet integration
- **Other**: Lua, Python, Rust, YAML, Docker, Java, Svelte

## Auto-formatting

Auto-formatting is configured for:
- TypeScript/JavaScript (Prettier with custom settings)
- HTML/CSS (Prettier)
- JSON (Prettier)
- Python (autopep8)

## Installation Notes

After updating your configuration:

1. **Restart Neovim** to load new plugins
2. **Run `:Lazy sync`** to install new plugins
3. **Run `:Mason`** to ensure all LSP servers are installed
4. **Run `:checkhealth`** to verify everything is working correctly

## Enhanced Features for Web Development

### Tailwind CSS
- IntelliSense with class name completion
- Color previews for Tailwind colors
- Conflict detection and warnings
- Support for custom regex patterns (clsx, classnames, cva, cn)

### React Development
- Automatic JSX tag closing and renaming
- Component extraction tools
- Enhanced syntax highlighting
- Styled-components support
- Better import management

### TypeScript Features
- Inlay hints for parameters and types
- Enhanced error messages with inline display
- Auto-import suggestions
- Better completion with module exports
- Type checking on save

## Troubleshooting

If you encounter issues:

1. Check `:checkhealth` for any problems
2. Ensure all LSP servers are installed via `:Mason`
3. Restart the LSP server: `:LspRestart`
4. Check plugin status: `:Lazy`

## Theme Integration

The configuration maintains your existing theme system and works with:
- Gruvbox
- Rose Pine
- Any other themes you have configured

All new UI elements respect your current colorscheme.