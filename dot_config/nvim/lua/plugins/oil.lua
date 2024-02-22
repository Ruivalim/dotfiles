table.insert(plugins, {
	"stevearc/oil.nvim",
	opts = {
		win_options = {
			signcolumn = "yes:2",
		},
		view_options = {
			show_hidden = true,
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
})

table.insert(plugins, {
	"refractalize/oil-git-status.nvim",
	dependencies = { "stevearc/oil.nvim" },
	config = true,
	opt = {
		show_ignored = true,
	},
})
