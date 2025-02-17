table.insert(plugins, {
	"akinsho/nvim-toggleterm.lua",
	config = function()
		require("toggleterm").setup({
			size = 20,
			direction = "float",
		})
	end,
})
