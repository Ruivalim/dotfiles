table.insert(plugins, {
	"s1n7ax/nvim-search-and-replace",
	opts = {
		setup = function()
			require("nvim-search-and-replace").setup()
		end,
	},
})
