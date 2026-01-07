vim.g.mapleader = " "
vim.g.maplocalleader = " "

function _G.check_back_space()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})

-- Quick escape from insert mode
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

-- Quick save
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { noremap = true, silent = true, desc = "Save" })
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<cr>", { noremap = true, silent = true, desc = "Save" })
vim.keymap.set("v", "<C-s>", "<Esc><cmd>w<cr>", { noremap = true, silent = true, desc = "Save" })

-- Quick find files
vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true, desc = "Find Files" })
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

for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, "<Cmd>BufferGoto " .. i .. "<CR>")
end

-- Neo-tree helper functions
local function is_neotree_focused()
	return vim.bo.filetype == "neo-tree"
end

local function get_neotree_win()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "neo-tree" then
			return win
		end
	end
	return nil
end

local function get_code_win()
	local special_fts = { "neo-tree", "trouble", "qf", "help", "toggleterm", "notify", "noice" }
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.bo[buf].filetype
		local is_special = vim.tbl_contains(special_fts, ft)
		if not is_special and ft ~= "" then
			return win
		end
	end
	return nil
end

wk.add({
	-- Buffer management
	{ "<leader>b", group = "Buffer", nowait = true, remap = false },
	{ "<leader>bc", "<cmd>BufferClose<cr>", desc = "Close", nowait = true, remap = false },
	{ "<leader>ba", "<cmd>BufferCloseAllButCurrent<cr>", desc = "Close All But Current", nowait = true, remap = false },
	{ "<leader>bj", "<cmd>BufferPick<cr>", desc = "Jump", nowait = true, remap = false },
	{ "<leader>bn", "<cmd>BufferNext<cr>", desc = "Next", nowait = true, remap = false },
	{ "<leader>bp", "<cmd>BufferPrevious<cr>", desc = "Previous", nowait = true, remap = false },

	-- File operations
	{ "<leader>f", group = "File", nowait = true, remap = false },
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", nowait = true, remap = false },
	{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
	{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep", nowait = true, remap = false },
	{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep String", nowait = true, remap = false },
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers", nowait = true, remap = false },
	{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags", nowait = true, remap = false },
	{ "<leader>fp", ":Telescope projects<CR>", desc = "Find Projects", nowait = true, remap = false },
	{ "<leader>fe", "<cmd>Neotree reveal<cr>", desc = "Reveal in Explorer", nowait = true, remap = false },
	{
		"<leader>fw",
		function()
			require("telescope.builtin").find_files({
				prompt_title = "Work Projects",
				cwd = "~/work",
				search_dirs = { "~/work" },
			})
		end,
		desc = "Find in Work Projects",
		nowait = true,
		remap = false,
	},

	-- File explorers
	{ "<leader>o", "<cmd>Oil<cr>", desc = "Toggle Oil", nowait = true, remap = false },
	{
		"<leader>e",
		function()
			local neotree_win = get_neotree_win()
			if neotree_win == nil then
				vim.cmd("Neotree focus")
			elseif is_neotree_focused() then
				local code_win = get_code_win()
				if code_win then
					vim.api.nvim_set_current_win(code_win)
				end
			else
				vim.api.nvim_set_current_win(neotree_win)
			end
		end,
		desc = "Toggle Neo-tree Focus",
		nowait = true,
		remap = false,
	},
	{ "<leader>E", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree", nowait = true, remap = false },

	-- Plugins
	{ "<leader>p", group = "Plugins", nowait = true, remap = false },
	{ "<leader>pl", "<cmd>Lazy<cr>", desc = "Lazy", nowait = true, remap = false },
	{ "<leader>pm", "<cmd>Mason<cr>", desc = "Mason", nowait = true, remap = false },

	-- Toggle options
	{ "<leader>t", group = "Toggle", nowait = true, remap = false },
	{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal", nowait = true, remap = false },
	{ "<leader>th", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = "Toggle Inlay Hints", nowait = true, remap = false },
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

	-- Search
	{ "<leader>s", group = "Search", nowait = true, remap = false },
	{ "<leader>sr", "<cmd>SReplaceAndSave<cr>", desc = "Search, Replace, Save", nowait = true, remap = false },

	-- Notes
	{ "<leader>n", group = "Notes/Noice", nowait = true, remap = false },
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

	-- WebDAV
	{ "<leader>w", group = "WebDav", nowait = true, remap = false },
	{ "<leader>wc", "<cmd>WebDAVConnect<cr>", desc = "Connect to WebDAV Server", nowait = true, remap = false },
	{ "<leader>wd", "<cmd>WebDAVDeleteServer<cr>", desc = "Delete WebDAV Server", nowait = true, remap = false },
	{ "<leader>wb", "<cmd>WebDAVBrowse<cr>", desc = "Browse WebDAV Server", nowait = true, remap = false },
	{ "<leader>ws", "<cmd>WebDAVServers<cr>", desc = "WebDAV Servers", nowait = true, remap = false },
	{ "<leader>wf", "<cmd>WebDAVSearch<cr>", desc = "WebDAV Search", nowait = true, remap = false },

	-- LSP
	{ "<leader>l", group = "LSP", nowait = true, remap = false },
	{ "<leader>ld", vim.lsp.buf.definition, desc = "Go to Definition", nowait = true, remap = false },
	{ "<leader>lr", vim.lsp.buf.references, desc = "Find References", nowait = true, remap = false },
	{ "<leader>lI", vim.lsp.buf.implementation, desc = "Go to Implementation", nowait = true, remap = false },
	{ "<leader>lt", vim.lsp.buf.type_definition, desc = "Type Definition", nowait = true, remap = false },
	{ "<leader>lh", vim.lsp.buf.hover, desc = "Hover Info", nowait = true, remap = false },
	{ "<leader>la", vim.lsp.buf.code_action, desc = "Code Actions", nowait = true, remap = false },
	{ "<leader>ln", ":IncRename ", desc = "Rename Symbol", nowait = true, remap = false },

	-- Diagnostics
	{ "<leader>d", group = "Diagnostics", nowait = true, remap = false },
	{ "<leader>dd", vim.diagnostic.open_float, desc = "Show Diagnostics", nowait = true, remap = false },
	{ "<leader>dn", vim.diagnostic.goto_next, desc = "Next Diagnostic", nowait = true, remap = false },
	{ "<leader>dp", vim.diagnostic.goto_prev, desc = "Previous Diagnostic", nowait = true, remap = false },
	{ "<leader>dw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics", nowait = true, remap = false },
	{ "<leader>db", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics", nowait = true, remap = false },

	-- Session (auto-session)
	{ "<leader>q", group = "Session", nowait = true, remap = false },
	{ "<leader>qs", "<cmd>SessionSearch<cr>", desc = "Search Sessions", nowait = true, remap = false },
	{ "<leader>qS", "<cmd>SessionSave<cr>", desc = "Save Session", nowait = true, remap = false },
	{ "<leader>qr", "<cmd>SessionRestore<cr>", desc = "Restore Session", nowait = true, remap = false },
	{ "<leader>qd", "<cmd>SessionDelete<cr>", desc = "Delete Session", nowait = true, remap = false },

	-- Projects
	{ "<leader>pp", ":Telescope projects<CR>", desc = "Switch Project", nowait = true, remap = false },

	-- Git
	{ "<leader>g", group = "Git", nowait = true, remap = false },
	{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit", nowait = true, remap = false },
	{ "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Commit", nowait = true, remap = false },
	{ "<leader>gp", "<cmd>Neogit push<cr>", desc = "Push", nowait = true, remap = false },
	{ "<leader>gl", "<cmd>Neogit pull<cr>", desc = "Pull", nowait = true, remap = false },
	{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff View", nowait = true, remap = false },
	{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History", nowait = true, remap = false },
	{ "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close Diff View", nowait = true, remap = false },

	-- Package Management (package.json / bun)
	{ "<leader>pk", group = "Package", nowait = true, remap = false },
	{
		"<leader>pku",
		"<cmd>lua require('package-info').update()<cr>",
		desc = "Update Dependency",
		nowait = true,
		remap = false,
	},
	{
		"<leader>pkd",
		"<cmd>lua require('package-info').delete()<cr>",
		desc = "Delete Dependency",
		nowait = true,
		remap = false,
	},
	{
		"<leader>pki",
		"<cmd>lua require('package-info').install()<cr>",
		desc = "Install Dependency",
		nowait = true,
		remap = false,
	},
	{
		"<leader>pkc",
		"<cmd>lua require('package-info').change_version()<cr>",
		desc = "Change Version",
		nowait = true,
		remap = false,
	},
	{
		"<leader>pkt",
		"<cmd>lua require('package-info').toggle()<cr>",
		desc = "Toggle Package Info",
		nowait = true,
		remap = false,
	},

	-- Extras
	{ "<leader>x", group = "Extras", nowait = true, remap = false },
	{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "TODOs in Trouble", nowait = true, remap = false },
})

require("neovide")
