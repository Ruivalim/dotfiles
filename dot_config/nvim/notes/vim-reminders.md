## Global

- **`:vsplit`**: Split the window vertically.
- **`:split`**: Split the window horizontally.
- **`<c-w> h`**: Move to the split on the left.
- **`<c-w> j`**: Move to the split below.
- **`<c-w> k`**: Move to the split above.
- **`<c-w> l`**: Move to the split on the right.
- **`<c-w> +`**: Increase the height of the current split.
- **`<c-w> -`**: Decrease the height of the current split.
- **`<c-w> >`**: Increase the width of the current split.
- **`<c-w> <`**: Decrease the width of the current split.

## Insert Mode

- **`<TAB>`**: If the completion menu is visible, select the next item; otherwise, check for backspace or refresh completion.
- **`<S-TAB>`**: If the completion menu is visible, select the previous item; otherwise, perform a backspace.
- **`<c-space>`**: Refresh the completion menu.
- **`<cr>`**: If the completion menu is visible, confirm the selection; otherwise, insert a newline.
- **`<c-j>`**: Expand or jump in snippets.

## Normal Mode

- **`ciw`**: Change the inner word.
- **`ci(`**: Change the inner parentheses.
- **`ci[`**: Change the inner brackets.
- **`ci{`**: Change the inner braces.
- **`ci"`**: Change the inner quotes.
- **`ci'`**: Change the inner single quotes.
- **`ci<`**: Change the inner angle brackets.
- **`K`**: Show hover information for the symbol under the cursor.
- **`<C-d>`**: Scroll down half a page and center the cursor.
- **`<C-u>`**: Scroll up half a page and center the cursor.
- **`s`**: Jump to a location using the "flash" plugin.
- **`gd`**: Go to the definition of the symbol under the cursor.
- **`gD`**: Go to the declaration of the symbol under the cursor.
- **`gy`**: Go to the type definition of the symbol under the cursor.
- **`gi`**: Go to the implementation of the symbol under the cursor.
- **`gr`**: Show references to the symbol under the cursor.
- **`<leader>ca`**: Show code actions for the symbol under the cursor.
- **`<leader>rn`**: Rename the symbol under the cursor.
- **`[d`**: Go to the previous diagnostic.
- **`]d`**: Go to the next diagnostic.
- **`<leader>e`**: Show diagnostic details in a floating window.
- **`<leader>q`**: Add diagnostics to the quickfix list.
- **`<leader>bc`**: Close the current buffer.
- **`<leader>ba`**: Close all buffers except the current one.
- **`<leader>bj`**: Pick a buffer to jump to.
- **`<leader>bn`**: Go to the next buffer.
- **`<leader>bp`**: Go to the previous buffer.
- **`<leader>ff`**: Find a file using Telescope.
- **`<leader>fr`**: Open a recently used file using Telescope.
- **`<leader>o`**: Open the Oil plugin.
- **`<leader>pl`**: Open the Lazy plugin manager.
- **`<leader>pm`**: Open the Mason plugin manager.
- **`<leader>u`**: Toggle the Mundo plugin.
- **`<leader>tt`**: Toggle the integrated terminal.
- **`<leader>sr`**: Search, replace, and save changes.
- **`<leader>ng`**: Toggle global notes.
- **`<leader>np`**: Toggle project-local notes.
- **`<leader>nv`**: Toggle Vim notes.

## LSP & Code Navigation

### Go to Definition/Import
- **`gd`**: Go to definition (works for imported modules/functions)
- **`gD`**: Go to declaration (useful for function declarations)
- **`gy`**: Go to type definition (helpful for TypeScript/Rust types)
- **`gi`**: Go to implementation (finds actual implementation)
- **`gr`**: Find all references (shows where symbol is used)

### Using Telescope for Advanced Navigation
- **`<leader>ff`**: Find files (search for specific module files)
- **`:Telescope live_grep`**: Search text across all files
- **`:Telescope grep_string`**: Search for word under cursor
- **`:Telescope lsp_references`**: Find references using LSP
- **`:Telescope lsp_definitions`**: Find definitions using LSP
- **`:Telescope lsp_type_definitions`**: Find type definitions using LSP
- **`:Telescope lsp_implementations`**: Find implementations using LSP
- **`:Telescope lsp_document_symbols`**: Browse symbols in current file
- **`:Telescope lsp_workspace_symbols`**: Browse symbols in workspace

### Working with Imports
- **`K`**: Show hover info (displays import source/docs)
- **`<leader>ca`**: Code actions (auto-import suggestions)
- **`<leader>rn`**: Rename symbol (updates imports too)

### Diagnostics & Errors
- **`[d`**: Previous diagnostic/error
- **`]d`**: Next diagnostic/error
- **`<leader>e`**: Show diagnostic details
- **`<leader>q`**: Add diagnostics to quickfix list

### Quick Tips
- Use `gd` on any imported symbol to jump to its definition
- Use `gr` to see all places where an import is used
- Use `K` to quickly see documentation for imported functions
- Use `:Telescope live_grep` + import name to find import statements

## Visual Mode

- **`>`**: Indent the selected text and reselect it.
- **`<`**: Outdent the selected text and reselect it.

## On Oil Buffer

- **`<C-p>`**: Preview the selected file.

## Plugin Suggestions

### Code Navigation & Understanding
- **`folke/trouble.nvim`** - Better diagnostics/quickfix list (integrates well with LSP)
- **`simrat39/symbols-outline.nvim`** - Code outline sidebar for navigating large files
- **`nvim-treesitter/nvim-treesitter-textobjects`** - Better text objects (select functions, classes, etc.)
- **`andymass/vim-matchup`** - Enhanced % matching for brackets, tags, keywords

### Code Quality & Productivity  
- **`windwp/nvim-autopairs`** - Auto-close brackets/quotes (modern alternative to delimitmate)
- **`numToStr/Comment.nvim`** - Better commenting with `gcc`, `gbc`
- **`kylechui/nvim-surround`** - Manipulate surrounds (quotes, brackets, etc.)
- **`mg979/vim-visual-multi`** - Multiple cursors support
- **`folke/todo-comments.nvim`** - Highlight and search TODO/FIXME comments

### File Management & Navigation
- **`ThePrimeagen/harpoon`** - Quick file switching (mark frequently used files)
- **`stevearc/dressing.nvim`** - Better UI for vim.ui.select/input
- **`folke/which-key.nvim`** - Already have this! Shows key bindings

### Git Integration
- **`sindrets/diffview.nvim`** - Better git diff views
- **`TimUntersberger/neogit`** - Full git interface in neovim
- **`f-person/git-blame.nvim`** - Inline git blame

### Search & Replace
- **`windwp/nvim-spectre`** - Project-wide search and replace with live preview
- **`cshuaimin/ssr.nvim`** - Structural search and replace

### UI Enhancements
- **`folke/noice.nvim`** - Better command line, messages, and popups
- **`rcarriga/nvim-notify`** - Already have this! Better notifications
- **`akinsho/bufferline.nvim`** - Better buffer tabs (alternative to barbar)
- **`nvim-tree/nvim-web-devicons`** - File icons

### Language & Syntax
- **`windwp/nvim-ts-autotag`** - Auto close/rename HTML tags
- **`JoosepAlviste/nvim-ts-context-commentstring`** - Better commenting in mixed files
- **`p00f/nvim-ts-rainbow`** - Rainbow parentheses

### Utilities
- **`folke/zen-mode.nvim`** - Distraction-free coding
- **`folke/twilight.nvim`** - Dim inactive code
- **`iamcco/markdown-preview.nvim`** - Live markdown preview
- **`wakatime/vim-wakatime`** - Time tracking

### Configuration Tweaks
- `vim.opt.relativenumber = true` - Relative line numbers for easier movement
- `vim.opt.scrolloff = 8` - Keep cursor centered while scrolling
- `vim.opt.signcolumn = "yes"` - Consistent gutter width
- `vim.opt.updatetime = 50` - Faster completion
- `vim.opt.colorcolumn = "80"` - Visual line length guide
