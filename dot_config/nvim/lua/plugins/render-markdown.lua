table.insert(plugins, {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
	ft = { "markdown" },
	config = function()
		require("render-markdown").setup({
			enabled = true,
			heading = {
				enabled = true,
				sign = true,
				icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			},
			code = {
				enabled = true,
				sign = true,
				style = "full",
				left_pad = 2,
				right_pad = 2,
			},
			bullet = {
				enabled = true,
				icons = { "●", "○", "◆", "◇" },
			},
			checkbox = {
				enabled = true,
				unchecked = { icon = " " },
				checked = { icon = " " },
			},
			quote = {
				enabled = true,
				icon = "▋",
			},
			-- Auto-render ao abrir arquivo markdown
			render_modes = { "n", "c" },
		})
	end,
})

-- Usage:
-- Abre qualquer arquivo .md e o markdown será renderizado automaticamente
-- Checkboxes interativos: [ ] vira  e [x] vira
-- Toggle render: <leader>tm (se configurado)
