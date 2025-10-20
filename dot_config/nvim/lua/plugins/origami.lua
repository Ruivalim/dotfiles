table.insert(plugins, {
	"chrisgrieser/nvim-origami",
	event = "VeryLazy",
	opts = {
		foldKeymaps = {
			setup = false,
		},
	},
	init = function()
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
	end,
})

table.insert(after_load, function()
	vim.keymap.set("n", "<Left>", function()
		require("origami").h()
	end)
	vim.keymap.set("n", "<Right>", function()
		require("origami").l()
	end)
	vim.keymap.set("n", "<End>", function()
		require("origami").dollar()
	end)
end)
