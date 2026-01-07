-- glance.nvim - Peek definitions/references in popup
table.insert(plugins, {
	"dnlhc/glance.nvim",
	cmd = "Glance",
	keys = {
		{ "gd", "<cmd>Glance definitions<cr>", desc = "Glance Definitions" },
		{ "gr", "<cmd>Glance references<cr>", desc = "Glance References" },
		{ "gy", "<cmd>Glance type_definitions<cr>", desc = "Glance Type Definitions" },
		{ "gi", "<cmd>Glance implementations<cr>", desc = "Glance Implementations" },
	},
	config = function()
		local glance = require("glance")
		glance.setup({
			height = 18,
			zindex = 45,
			detached = true,
			preview_win_opts = {
				cursorline = true,
				number = true,
				wrap = true,
			},
			border = {
				enable = true,
				top_char = "―",
				bottom_char = "―",
			},
			list = {
				position = "right",
				width = 0.33,
			},
			theme = {
				enable = true,
				mode = "auto",
			},
			mappings = {
				list = {
					["j"] = glance.actions.next,
					["k"] = glance.actions.previous,
					["<Down>"] = glance.actions.next,
					["<Up>"] = glance.actions.previous,
					["<Tab>"] = glance.actions.next_location,
					["<S-Tab>"] = glance.actions.previous_location,
					["<C-u>"] = glance.actions.preview_scroll_win(5),
					["<C-d>"] = glance.actions.preview_scroll_win(-5),
					["v"] = glance.actions.jump_vsplit,
					["s"] = glance.actions.jump_split,
					["t"] = glance.actions.jump_tab,
					["<CR>"] = glance.actions.jump,
					["o"] = glance.actions.jump,
					["l"] = glance.actions.open_fold,
					["h"] = glance.actions.close_fold,
					["<Esc>"] = glance.actions.close,
					["q"] = glance.actions.close,
				},
				preview = {
					["<Tab>"] = glance.actions.next_location,
					["<S-Tab>"] = glance.actions.previous_location,
					["<Esc>"] = glance.actions.close,
					["q"] = glance.actions.close,
				},
			},
			folds = {
				fold_closed = "",
				fold_open = "",
				folded = true,
			},
			indent_lines = {
				enable = true,
				icon = "│",
			},
			winbar = {
				enable = true,
			},
		})
	end,
})
