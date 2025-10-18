-- Neovide Configuration
if vim.g.neovide then
	vim.g.neovide_input_macos_option_key_is_meta = "both"

	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_cursor_animation_length = 0.05
	vim.g.neovide_cursor_trail_size = 0.8
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_animate_command_line = true

	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	vim.g.neovide_opacity = 0.95

	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_refresh_rate_idle = 5

	local function map(modes, lhs, rhs, desc)
		for _, mode in ipairs(modes) do
			vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
		end
	end

	-- Clipboard operations (Cmd+C/V/X)
	map({ "n", "v" }, "<D-c>", '"+y', "Copy to clipboard")
	map({ "n", "v" }, "<D-x>", '"+d', "Cut to clipboard")
	map({ "n", "v" }, "<D-v>", '"+p', "Paste from clipboard")
	map({ "i", "c" }, "<D-v>", "<C-r>+", "Paste from clipboard")

	-- Select All (Cmd+A)
	map({ "n", "v", "i" }, "<D-a>", "<Esc>ggVG", "Select all")

	-- Save (Cmd+S)
	vim.keymap.set("n", "<D-s>", ":w<CR>", { desc = "Save file", silent = true })
	vim.keymap.set("i", "<D-s>", "<Esc>:w<CR>a", { desc = "Save file", silent = true })
	vim.keymap.set("v", "<D-s>", "<Esc>:w<CR>gv", { desc = "Save file", silent = true })

	-- Undo/Redo (Cmd+Z/Cmd+Shift+Z)
	vim.keymap.set("n", "<D-z>", "u", { desc = "Undo", silent = true })
	vim.keymap.set("i", "<D-z>", "<C-o>u", { desc = "Undo", silent = true })
	vim.keymap.set("n", "<D-S-z>", "<C-r>", { desc = "Redo", silent = true })
	vim.keymap.set("i", "<D-S-z>", "<C-o><C-r>", { desc = "Redo", silent = true })

	-- Quit (Cmd+Q) - improved to handle unsaved changes
	vim.keymap.set("n", "<D-q>", ":confirm qa<CR>", { desc = "Quit", silent = true })
	vim.keymap.set("v", "<D-q>", "<Esc>:confirm qa<CR>", { desc = "Quit", silent = true })
	vim.keymap.set("i", "<D-q>", "<Esc>:confirm qa<CR>", { desc = "Quit", silent = true })

	-- Close current buffer (Cmd+W)
	vim.keymap.set("n", "<D-w>", ":confirm bd<CR>", { desc = "Close buffer", silent = true })
	vim.keymap.set("i", "<D-w>", "<Esc>:confirm bd<CR>", { desc = "Close buffer", silent = true })

	-- New tab/file (Cmd+T/Cmd+N)
	vim.keymap.set("n", "<D-t>", ":tabnew<CR>", { desc = "New tab", silent = true })
	vim.keymap.set("n", "<D-n>", ":enew<CR>", { desc = "New file", silent = true })

	-- Find (Cmd+F)
	vim.keymap.set("n", "<D-f>", "/", { desc = "Find" })
	vim.keymap.set("v", "<D-f>", "/", { desc = "Find" })

	-- Find and replace (Cmd+R)
	vim.keymap.set("n", "<D-r>", ":%s/", { desc = "Find and replace" })
	vim.keymap.set("v", "<D-r>", ":s/", { desc = "Find and replace in selection" })

	-- Font size adjustment (Cmd +/-)
	vim.keymap.set(
		"n",
		"<D-=>",
		":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
		{ desc = "Increase font size", silent = true }
	)
	vim.keymap.set(
		"n",
		"<D-->",
		":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
		{ desc = "Decrease font size", silent = true }
	)
	vim.keymap.set("n", "<D-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { desc = "Reset font size", silent = true })

	-- Tab navigation (Cmd+1-9)
	for i = 1, 9 do
		vim.keymap.set("n", "<D-" .. i .. ">", i .. "gt", { desc = "Go to tab " .. i, silent = true })
	end

	-- Navigate between splits (Cmd+h/j/k/l)
	vim.keymap.set("n", "<D-h>", "<C-w>h", { desc = "Move to left split", silent = true })
	vim.keymap.set("n", "<D-j>", "<C-w>j", { desc = "Move to bottom split", silent = true })
	vim.keymap.set("n", "<D-k>", "<C-w>k", { desc = "Move to top split", silent = true })
	vim.keymap.set("n", "<D-l>", "<C-w>l", { desc = "Move to right split", silent = true })

	-- Toggle fullscreen (Cmd+Ctrl+F)
	vim.keymap.set(
		"n",
		"<D-C-f>",
		":lua vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen<CR>",
		{ desc = "Toggle fullscreen", silent = true }
	)
end
