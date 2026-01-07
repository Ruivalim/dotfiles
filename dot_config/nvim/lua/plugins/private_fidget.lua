-- fidget.nvim - LSP progress indicator
table.insert(plugins, {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	opts = {
		progress = {
			poll_rate = 0,
			suppress_on_insert = false,
			ignore_done_already = false,
			ignore_empty_message = false,
			display = {
				render_limit = 16,
				done_ttl = 3,
				done_icon = "✓",
				done_style = "Constant",
				progress_ttl = math.huge,
				progress_icon = { pattern = "dots", period = 1 },
				progress_style = "WarningMsg",
				group_style = "Title",
				icon_style = "Question",
				priority = 30,
				skip_history = true,
			},
		},
		notification = {
			poll_rate = 10,
			filter = vim.log.levels.INFO,
			history_size = 128,
			override_vim_notify = false,
			window = {
				normal_hl = "Comment",
				winblend = 0,
				border = "none",
				zindex = 45,
				max_width = 0,
				max_height = 0,
				x_padding = 1,
				y_padding = 0,
				align = "bottom",
				relative = "editor",
			},
		},
	},
})
