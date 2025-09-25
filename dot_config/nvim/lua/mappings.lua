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
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})
vim.keymap.set("n", "s", '<cmd>lua require("flash").jump()<cr>', {})

vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
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
	{ "<leader>t", group = "Toggle", nowait = true, remap = false },
	{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal", nowait = true, remap = false },
	{
		"<leader>tp",
		function()
			require("precognition").toggle()
		end,
		desc = "Toggle Precognition",
		nowait = true,
		remap = false,
	},
	{
		"<leader>tm",
		function()
			require("render-markdown").toggle()
		end,
		desc = "Toggle Markdown Render",
		nowait = true,
		remap = false,
	},
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
	{ "<leader>l", group = "LSP", nowait = true, remap = false },
	{ "<leader>ld", vim.lsp.buf.definition, desc = "Go to Definition", nowait = true, remap = false },
	{ "<leader>lr", vim.lsp.buf.references, desc = "Find References", nowait = true, remap = false },
	{ "<leader>lI", vim.lsp.buf.implementation, desc = "Go to Implementation", nowait = true, remap = false },
	{ "<leader>lt", vim.lsp.buf.type_definition, desc = "Type Definition", nowait = true, remap = false },
	{ "<leader>lh", vim.lsp.buf.hover, desc = "Hover Info", nowait = true, remap = false },
	{ "<leader>la", vim.lsp.buf.code_action, desc = "Code Actions", nowait = true, remap = false },
	{ "<leader>ln", vim.lsp.buf.rename, desc = "Rename Symbol", nowait = true, remap = false },
	{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep", nowait = true, remap = false },
	{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep String", nowait = true, remap = false },
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers", nowait = true, remap = false },
	{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags", nowait = true, remap = false },
	{ "<leader>d", group = "Diagnostics", nowait = true, remap = false },
	{ "<leader>dd", vim.diagnostic.open_float, desc = "Show Diagnostics", nowait = true, remap = false },
	{ "<leader>dn", vim.diagnostic.goto_next, desc = "Next Diagnostic", nowait = true, remap = false },
	{ "<leader>dp", vim.diagnostic.goto_prev, desc = "Previous Diagnostic", nowait = true, remap = false },
	{
		"<leader>dw",
		"<cmd>Trouble diagnostics toggle<cr>",
		desc = "Workspace Diagnostics",
		nowait = true,
		remap = false,
	},
	{
		"<leader>db",
		"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		desc = "Buffer Diagnostics",
		nowait = true,
		remap = false,
	},
})
