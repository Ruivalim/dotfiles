table.insert(plugins, {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"markdown",
				"markdown_inline",
				"json",
				"jsonc",
				"yaml",
				"html",
				"css",
				"scss",
				"javascript",
				"typescript",
				"tsx",
				"rust",
				"python",
				"go",
				"toml",
				"dockerfile",
				"graphql",
				"regex",
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
			},
			refactor = {
				highlight_definitions = {
					enable = true,
				},
			},
		})
	end,
})
