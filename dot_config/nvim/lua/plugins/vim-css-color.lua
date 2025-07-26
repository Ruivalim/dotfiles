table.insert(plugins, {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup()
	end,
})
