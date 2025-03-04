table.insert(plugins, {
	"morhetz/gruvbox",
	name = "gruvbox",
})

table.insert(after_load, function()
	vim.cmd([[colorscheme gruvbox]])
end)
