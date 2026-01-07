-- vim-visual-multi - Multiple cursors
table.insert(plugins, {
	"mg979/vim-visual-multi",
	branch = "master",
	event = "VeryLazy",
	init = function()
		vim.g.VM_default_mappings = 1
		vim.g.VM_maps = {
			["Find Under"] = "<C-n>",
			["Find Subword Under"] = "<C-n>",
			["Select Cursor Down"] = "<M-C-Down>",
			["Select Cursor Up"] = "<M-C-Up>",
			["Select All"] = "<C-S-n>",
			["Skip Region"] = "q",
			["Remove Region"] = "Q",
		}
		vim.g.VM_theme = "iceblue"
	end,
})
