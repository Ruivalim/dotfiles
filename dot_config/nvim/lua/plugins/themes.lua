table.insert(plugins, {
	"morhetz/gruvbox",
	name = "gruvbox",
})

table.insert(plugins, {
	"rose-pine/neovim",
	name = "rose-pine",
})

table.insert(after_load, function()
	-- 	vim.cmd([[colorscheme rose-pine]])
	-- vim.cmd([[colorscheme gruvbox]])
end)
