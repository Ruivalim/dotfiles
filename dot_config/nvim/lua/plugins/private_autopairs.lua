-- Autopairs - Auto close brackets, quotes, etc.
table.insert(plugins, {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = { "hrsh7th/nvim-cmp" },
	config = function()
		local autopairs = require("nvim-autopairs")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")

		autopairs.setup({
			check_ts = true,
			ts_config = {
				lua = { "string" },
				javascript = { "template_string" },
				typescript = { "template_string" },
				javascriptreact = { "template_string" },
				typescriptreact = { "template_string" },
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			disable_in_macro = true,
			disable_in_visualblock = false,
			disable_in_replace_mode = true,
			ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
			enable_moveright = true,
			enable_afterquote = true,
			enable_check_bracket_line = true,
			enable_bracket_in_quote = true,
			enable_abbr = false,
			break_undo = true,
			map_cr = true,
			map_bs = true,
			map_c_h = false,
			map_c_w = false,
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		})

		-- Integration with nvim-cmp
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
})
