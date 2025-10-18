table.insert(plugins, {
	"petertriho/nvim-scrollbar",
	config = function()
		require("scrollbar").setup({})
	end,
})
