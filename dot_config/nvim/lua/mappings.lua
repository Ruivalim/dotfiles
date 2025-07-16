vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- <c-p> on oil to preview file
-- ciw delete current word
-- :vplit to vertical split
-- :split to horizontal split
-- <c-w> + hjkl to move between splits
-- <c-w> + +-<> to resize splits
function _G.check_back_space()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", {})
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", {})
vim.api.nvim_set_keymap("n", "s", '<cmd>lua require("flash").jump()<cr>', {})

vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy selection to clipboard" })
local clipboard_enabled = false
vim.keymap.set("n", "<leader>tc", function()
	if clipboard_enabled then
		vim.opt.clipboard = ""
		clipboard_enabled = false
		vim.notify("Clipboard disabled")
	else
		vim.opt.clipboard = "unnamedplus"
		clipboard_enabled = true
		vim.notify("Clipboard enabled")
	end
end, { desc = "Toggle clipboard" })

local wk = require("which-key")
local global_note = require("global-note")
wk.add({
	{ "<leader>b", group = "Buffer", nowait = true, remap = false },
	{ "<leader>bc", "<cmd>BufferClose<cr>", desc = "Close", nowait = true, remap = false },
	{ "<leader>ba", "<cmd>BufferCloseAllButCurrent<cr>", desc = "Close All But Current", nowait = true, remap = false },
	{ "<leader>bj", "<cmd>BufferPick<cr>", desc = "Jump", nowait = true, remap = false },
	{ "<leader>bn", "<cmd>BufferNext<cr>", desc = "Next", nowait = true, remap = false },
	{ "<leader>bp", "<cmd>BufferPrevious<cr>", desc = "Previous", nowait = true, remap = false },
	{ "<leader>f", group = "File", nowait = true, remap = false },
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", nowait = true, remap = false },
	{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
	{ "<leader>o", "<cmd>Oil<cr>", desc = "Oil", nowait = true, remap = false },
	{ "<leader>p", group = "Plugins", nowait = true, remap = false },
	{ "<leader>pl", "<cmd>Lazy<cr>", desc = "Lazy", nowait = true, remap = false },
	{ "<leader>pm", "<cmd>Mason<cr>", desc = "Mason", nowait = true, remap = false },
	{ "<leader>u", "<cmd>MundoToggle<cr>", desc = "Mundo Toggle", nowait = true, remap = false },
	{ "<leader>t", group = "Terminal", nowait = true, remap = false },
	{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal", nowait = true, remap = false },
	{ "<leader>s", group = "Search", nowait = true, remap = false },
	{ "<leader>sr", "<cmd>SReplaceAndSave<cr>", desc = "Search, Replace, Save", nowait = true, remap = false },
	{ "<leader>n", group = "Notes", nowait = true, remap = false },
	{
		"<leader>ng",
		function()
			global_note.toggle_note()
		end,
		desc = "Global Notes",
		nowait = true,
		remap = false,
	},
	{
		"<leader>np",
		function()
			global_note.toggle_note("project_local")
		end,
		desc = "Project Notes",
		nowait = true,
		remap = false,
	},
	{
		"<leader>nv",
		function()
			global_note.toggle_note("vim")
		end,
		desc = "Vim Notes",
		nowait = true,
		remap = false,
	},
	{
		"<leader>w",
		group = "WebDav",
		nowait = true,
		remap = false,
	},
	{ "<leader>wc", "<cmd>WebDAVConnect<cr>", desc = "Connect to WebDAV Server", nowait = true, remap = false },
	{ "<leader>wd", "<cmd>WebDAVDeleteServer<cr>", desc = "Delete WebDAV Server", nowait = true, remap = false },
	{ "<leader>wb", "<cmd>WebDAVBrowse<cr>", desc = "Browse WebDAV Server", nowait = true, remap = false },
	{ "<leader>ws", "<cmd>WebDAVServers<cr>", desc = "WebDAV Servers", nowait = true, remap = false },
	{ "<leader>wf", "<cmd>WebDAVSearch<cr>", desc = "WebDAV Search", nowait = true, remap = false },
})
