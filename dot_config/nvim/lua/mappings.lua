vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_set_keymap("n", "<Leader>", ":lua trigger_which_key()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

local wk = require("which-key")

wk.register({
	p = {
		name = "Plugins",
		l = { "<cmd>Lazy<cr>", "Lazy" },
		m = { "<cmd>Mason<cr>", "Mason" },
	},
	n = { "<cmd>Oil<cr>", "Oil" },
	u = { "<cmd>MundoToggle<cr>", "Mundo Toggle" },
	b = {
		name = "Buffer",
		j = { "<cmd>BufferPick<cr>", "Jump" },
		c = { "<cmd>BufferClose<cr>", "Close" },
		p = { "<cmd>BufferPrevious<cr>", "Previous" },
		n = { "<cmd>BufferNext<cr>", "Next" },
	},
	f = {
		name = "File",
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
	},
}, {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
})
