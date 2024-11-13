vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_set_keymap("n", "<Leader>", ":lua trigger_which_key()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })

local wk = require("which-key")

wk.add({
	{ "<leader>b", group = "Buffer", nowait = true, remap = false },
	{ "<leader>bc", "<cmd>BufferClose<cr>", desc = "Close", nowait = true, remap = false },
	{ "<leader>bj", "<cmd>BufferPick<cr>", desc = "Jump", nowait = true, remap = false },
	{ "<leader>bn", "<cmd>BufferNext<cr>", desc = "Next", nowait = true, remap = false },
	{ "<leader>bp", "<cmd>BufferPrevious<cr>", desc = "Previous", nowait = true, remap = false },
	{ "<leader>f", group = "File", nowait = true, remap = false },
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", nowait = true, remap = false },
	{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
	{ "<leader>n", "<cmd>Oil<cr>", desc = "Oil", nowait = true, remap = false },
	{ "<leader>p", group = "Plugins", nowait = true, remap = false },
	{ "<leader>pl", "<cmd>Lazy<cr>", desc = "Lazy", nowait = true, remap = false },
	{ "<leader>pm", "<cmd>Mason<cr>", desc = "Mason", nowait = true, remap = false },
	{ "<leader>u", "<cmd>MundoToggle<cr>", desc = "Mundo Toggle", nowait = true, remap = false },
})
