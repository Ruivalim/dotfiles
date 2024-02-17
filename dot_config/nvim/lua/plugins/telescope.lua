table.insert(plugins, {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.4",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		file_ignore_patterns = { "node%_modules/.*" },
	},
})
