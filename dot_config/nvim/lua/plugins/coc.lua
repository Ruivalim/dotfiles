table.insert(plugins, {
	"neoclide/coc.nvim",
	branch = "release",
})

table.insert(after_load, function()
	vim.g.coc_global_extensions = {
		"coc-json",
		"coc-git",
		"coc-lua",
		"coc-go",
		"coc-sh",
		"coc-emmet",
		"coc-docker",
		"coc-pretty-ts-errors",
		"coc-tsserver",
		"coc-rust-analyzer",
		"coc-css",
		"coc-zig",
	}
end)
