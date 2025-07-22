table.insert(plugins, {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		file_ignore_patterns = { "node%_modules/.*" },
	},
})
