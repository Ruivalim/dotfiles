-- lsp-signature - Show function signature while typing
table.insert(plugins, {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	opts = {
		bind = true,
		handler_opts = {
			border = "rounded",
		},
		hint_enable = true,
		hint_prefix = "󰏪 ",
		floating_window = true,
		floating_window_above_cur_line = true,
		hi_parameter = "LspSignatureActiveParameter",
		max_height = 12,
		max_width = 80,
		wrap = true,
		close_timeout = 4000,
		fix_pos = false,
		zindex = 200,
		padding = " ",
		toggle_key = "<C-k>",
	},
})
