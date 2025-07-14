table.insert(plugins, {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({})
	end,
})
