-- Neogit - Git interface
table.insert(plugins, {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	cmd = { "Neogit", "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
	opts = {
		integrations = {
			diffview = true,
			telescope = true,
		},
		signs = {
			section = { "", "" },
			item = { "", "" },
			hunk = { "", "" },
		},
	},
})
