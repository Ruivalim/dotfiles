table.insert(plugins, {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "moon",
	},
})

table.insert(after_load, function()
	vim.cmd([[colorscheme tokyonight]])
end)
