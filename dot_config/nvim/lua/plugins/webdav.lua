table.insert(plugins, {
	"Ruivalim/webdav.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	lazy = false,
	config = function()
		require("webdav").setup({
			servers = {},
			default_server = nil,
			timeout = 30,
			ui = {
				show_hidden = false,
				icons = {
					folder = "📁",
					file = "📄",
					locked = "🔒",
				},
			},
		})
	end,
	keys = {
		{ "<leader>wd", "<cmd>WebDAVBrowse<cr>", desc = "Browse WebDAV" },
		{ "<leader>wc", "<cmd>WebDAVConnect<cr>", desc = "Connect to WebDAV" },
		{ "<leader>ws", "<cmd>WebDAVServers<cr>", desc = "WebDAV Servers" },
	},
})
