## Global

- **`:vsplit`**: Split the window vertically.
- **`:split`**: Split the window horizontally.
- **`<C-h>`**: Move to the split on the left.
- **`<C-j>`**: Move to the split below.
- **`<C-k>`**: Move to the split above.
- **`<C-l>`**: Move to the split on the right.
- **`<C-Up>`**: Increase the height of the current split.
- **`<C-Down>`**: Decrease the height of the current split.
- **`<C-Right>`**: Increase the width of the current split.
- **`<C-Left>`**: Decrease the width of the current split.
- **`<Esc>`**: Clear search highlight.
- **`<C-s>`**: Save file (works in any mode).
- **`<leader><leader>`**: Quick find files.
- **`jk`**: Exit insert mode (instead of Esc).

## Insert Mode

- **`<TAB>`**: If the completion menu is visible, select the next item.
- **`<S-TAB>`**: If the completion menu is visible, select the previous item.
- **`<C-space>`**: Refresh the completion menu.
- **`<CR>`**: If the completion menu is visible, confirm the selection.
- **`<M-e>`**: Fast wrap with autopairs (wrap text with brackets/quotes).

## Normal Mode

### Text Objects
- **`ciw`**: Change the inner word.
- **`ci(`**: Change the inner parentheses.
- **`ci[`**: Change the inner brackets.
- **`ci{`**: Change the inner braces.
- **`ci"`**: Change the inner quotes.
- **`ci'`**: Change the inner single quotes.
- **`ci<`**: Change the inner angle brackets.
- **`cin)`**: Change inside NEXT ().
- **`cil"`**: Change inside LAST ".
- **`dan[`**: Delete around NEXT [].

### Surround (ys, cs, ds)
- **`ysiw"`**: Surround word with quotes.
- **`ysiw)`**: Surround word with ().
- **`yss"`**: Surround entire line with ".
- **`ds"`**: Delete surrounding quotes.
- **`ds)`**: Delete surrounding ().
- **`cs"'`**: Change " to '.
- **`cs)}`**: Change () to {}.

### Navigation
- **`K`**: Show hover information for the symbol under the cursor.
- **`<C-d>`**: Scroll down half a page and center the cursor.
- **`<C-u>`**: Scroll up half a page and center the cursor.
- **`s`**: Jump to a location using Flash.
- **`S`**: Jump using Flash Treesitter (select code blocks).
- **`n/N`**: Next/previous search result (centered).

### Harpoon (Quick File Navigation)
- **`<leader>a`**: Add current file to Harpoon.
- **`<leader>m`**: Open Harpoon menu.
- **`<M-1>` to `<M-5>`**: Jump to Harpoon file 1-5.
- **`<M-[>`**: Previous Harpoon file.
- **`<M-]>`**: Next Harpoon file.

### File Explorers
- **`<leader>o`**: Open Oil (quick file editing).
- **`<leader>e`**: Toggle Neo-tree sidebar.
- **`<leader>E`**: Reveal current file in Neo-tree.

### LSP
- **`<leader>ld`**: Go to definition.
- **`<leader>lI`**: Go to implementation.
- **`<leader>lt`**: Go to type definition.
- **`<leader>lr`**: Find references.
- **`<leader>la`**: Code actions.
- **`<leader>ln`**: Rename symbol.
- **`<leader>lh`**: Hover info.
- **`<C-k>`**: Toggle function signature (while typing).

### Glance (Peek definitions in popup)
- **`gd`**: Glance definitions.
- **`gr`**: Glance references.
- **`gy`**: Glance type definitions.
- **`gi`**: Glance implementations.

### Diagnostics
- **`<leader>dp`**: Previous diagnostic.
- **`<leader>dn`**: Next diagnostic.
- **`<leader>dd`**: Show diagnostic details.
- **`<leader>dw`**: Workspace diagnostics (Trouble).
- **`<leader>db`**: Buffer diagnostics (Trouble).

### TODOs
- **`]t`**: Next TODO comment.
- **`[t`**: Previous TODO comment.
- **`<leader>ft`**: Find TODOs (Telescope).
- **`<leader>xt`**: TODOs in Trouble.

### Buffers
- **`<leader>1-9`**: Jump to buffer 1-9.
- **`<leader>bc`**: Close current buffer.
- **`<leader>ba`**: Close all buffers except current.
- **`<leader>bj`**: Pick a buffer to jump to.
- **`<leader>bn`**: Next buffer.
- **`<leader>bp`**: Previous buffer.

### Files (Telescope)
- **`<leader>ff`**: Find files.
- **`<leader>fr`**: Recent files.
- **`<leader>fg`**: Live grep.
- **`<leader>fs`**: Grep string under cursor.
- **`<leader>fb`**: Find buffers.
- **`<leader>fh`**: Help tags.
- **`<leader>fp`**: Find projects.
- **`<leader>fw`**: Find in work projects.

### Session Management (auto-session)
- **`<leader>qs`**: Search sessions.
- **`<leader>qS`**: Save session.
- **`<leader>qr`**: Restore session.
- **`<leader>qd`**: Delete session.
- Sessions auto-save/restore when opening folders.

### Plugins
- **`<leader>pl`**: Open Lazy plugin manager.
- **`<leader>pm`**: Open Mason.

### Toggle
- **`<leader>tt`**: Toggle terminal.
- **`<leader>th`**: Toggle inlay hints (type hints).
- **`<leader>tp`**: Toggle Precognition.
- **`<leader>tm`**: Toggle Markdown render.
- **`<leader>tc`**: Toggle clipboard.

### Search & Replace
- **`<leader>sr`**: Search, replace, and save.

### Notes
- **`<leader>ng`**: Global notes.
- **`<leader>np`**: Project notes.
- **`<leader>nv`**: Vim notes.

### Noice (Messages)
- **`<leader>nl`**: Last message.
- **`<leader>nh`**: Message history.
- **`<leader>na`**: All messages.
- **`<leader>nd`**: Dismiss all.

### WebDAV
- **`<leader>wc`**: Connect to WebDAV server.
- **`<leader>wd`**: Delete WebDAV server.
- **`<leader>wb`**: Browse WebDAV server.
- **`<leader>ws`**: List WebDAV servers.
- **`<leader>wf`**: WebDAV search.

### Commenting (gcc)
- **`gcc`**: Toggle comment on line.
- **`gc`** + motion: Comment with motion (e.g., `gc3j` comments 3 lines down).
- **`gbc`**: Toggle block comment.
- **`gcO`**: Add comment above.
- **`gco`**: Add comment below.
- **`gcA`**: Add comment at end of line.

### Multiple Cursors (vim-visual-multi)
- **`<C-n>`**: Select word under cursor, press again for next occurrence.
- **`q`**: Skip current and go to next.
- **`Q`**: Remove current cursor.
- **`<C-S-n>`**: Select all occurrences.
- **`<M-C-Down/Up>`**: Add cursor below/above.

### Git (Neogit)
- **`<leader>gg`**: Open Neogit.
- **`<leader>gc`**: Git commit.
- **`<leader>gp`**: Git push.
- **`<leader>gl`**: Git pull.
- **`<leader>gd`**: Open diff view.
- **`<leader>gh`**: File history.

### Extras
- **`<leader>xe`**: Wrap with Emmet abbreviation (visual).
- **`<leader>y`**: Copy selection to clipboard (visual).

### React (Visual Mode)
- **`<leader>re`**: Extract React component to file.
- **`<leader>rc`**: Extract React component inline.

### Quickfix & Location
- **`<leader>qf`**: Open quickfix list.
- **`<leader>qc`**: Close quickfix list.
- **`]q`**: Next quickfix.
- **`[q`**: Previous quickfix.
- **`]l`**: Next location.
- **`[l`**: Previous location.

## Visual Mode

- **`>`**: Indent and reselect.
- **`<`**: Outdent and reselect.
- **`<A-j>`**: Move selection down.
- **`<A-k>`**: Move selection up.

## Neo-tree (File Explorer)

- **`<CR>` / `o` / `l`**: Open file.
- **`h`**: Close node.
- **`s`**: Open in vertical split.
- **`S`**: Open in horizontal split.
- **`t`**: Open in new tab.
- **`a`**: Add file.
- **`A`**: Add directory.
- **`d`**: Delete.
- **`r`**: Rename.
- **`y`**: Copy to clipboard.
- **`x`**: Cut to clipboard.
- **`p`**: Paste.
- **`P`**: Toggle preview.
- **`R`**: Refresh.
- **`?`**: Show help.
- **`q`**: Close.

## Oil Buffer

- **`<C-p>`**: Preview the selected file.
- **`-`**: Go up a directory.
- **`<CR>`**: Open file/directory.

## Telescope Tips

- **`:Telescope lsp_references`**: Find references using LSP.
- **`:Telescope lsp_definitions`**: Find definitions using LSP.
- **`:Telescope lsp_document_symbols`**: Browse symbols in current file.
- **`:Telescope lsp_workspace_symbols`**: Browse symbols in workspace.

## Configuration Tweaks

These are already set in your config:
- `vim.opt.relativenumber = true` - Relative line numbers
- `vim.opt.scrolloff = 8` - Keep cursor centered
- `vim.opt.signcolumn = "yes"` - Consistent gutter width
- `vim.opt.updatetime = 50` - Faster completion
