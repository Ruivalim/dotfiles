table.insert(plugins, {
	"stevearc/oil.nvim",
	opts = {
		columns = {
			"icon",
			"size",
			"mtime",
		},
		win_options = {
			signcolumn = "yes:2",
		},
		view_options = {
			show_hidden = true,
		},
		float = {
			preview_split = "right",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
})

table.insert(plugins, {
	"refractalize/oil-git-status.nvim",
	dependencies = { "stevearc/oil.nvim" },
	config = true,
	opts = {
		show_ignored = true,
	},
})
