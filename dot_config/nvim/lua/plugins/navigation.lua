table.insert(plugins, {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		labels = "asdfghjklqwertyuiopzxcvbnm",
		search = {
			multi_window = true,
			forward = true,
			wrap = false,
			mode = "exact",
		},
		jump = {
			jumplist = true,
			pos = "start",
			history = false,
			register = false,
			nohlsearch = false,
			autojump = false,
		},
		label = {
			uppercase = true,
			exclude = "",
			current = true,
			after = true,
			before = false,
			style = "overlay",
			reuse = "lowercase",
			distance = true,
			min_pattern_length = 0,
		},
		highlight = {
			backdrop = true,
			matches = true,
			priority = 5000,
			groups = {
				match = "FlashMatch",
				current = "FlashCurrent",
				backdrop = "FlashBackdrop",
				label = "FlashLabel",
			},
		},
		modes = {
			search = {
				enabled = true,
				highlight = { backdrop = false },
				jump = { history = true, register = true, nohlsearch = true },
			},
			char = {
				enabled = true,
				config = function(opts)
					opts.autohide = opts.autohide == nil and vim.fn.mode(true):find("no") and vim.v.operator == "y"
				end,
				autohide = false,
				jump_labels = false,
				multi_line = true,
				label = { exclude = "hjkliardc" },
				keys = { "f", "F", "t", "T", ";", "," },
			},
		},
		prompt = {
			enabled = true,
			prefix = { { "⚡", "FlashPromptIcon" } },
			win_config = {
				relative = "editor",
				width = 1,
				height = 1,
				row = -1,
				col = 0,
				zindex = 1000,
			},
		},
		remote_op = {
			restore = false,
			motion = false,
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "o", "x" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},
})

table.insert(plugins, {
	"ggandor/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	config = function()
		-- Don't create default mappings to avoid conflicts with flash.nvim
		require("leap").opts.safe_labels = "sfnut/SFNLHMUGTZ?"
		require("leap").opts.labels = "sfnjklhodweimbuyvrgtaqpcxz/SFNJKLHODWEIMBUYVRGTAQPCXZ?"
		require("leap").opts.case_sensitive = false
		require("leap").opts.equivalence_classes = { " \t\r\n" }

		-- Create custom mappings that don't conflict
		vim.keymap.set("n", "gl", function()
			require("leap").leap()
		end, { desc = "Leap forward" })
		vim.keymap.set("n", "gL", function()
			require("leap").leap({ backward = true })
		end, { desc = "Leap backward" })
		vim.keymap.set("x", "gl", function()
			require("leap").leap()
		end, { desc = "Leap forward" })
		vim.keymap.set("x", "gL", function()
			require("leap").leap({ backward = true })
		end, { desc = "Leap backward" })
	end,
})

table.insert(plugins, {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
})

table.insert(after_load, function()
	-- Enhanced navigation mappings
	vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
	vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
	vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result centered" })
	vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result centered" })

	-- Better window navigation
	vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
	vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
	vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
	vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

	-- Resize windows
	vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
	vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
	vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
	vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

	-- Move lines up/down
	vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
	vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
	vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
	vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
	vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
	vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

	-- Better indenting
	vim.keymap.set("v", "<", "<gv")
	vim.keymap.set("v", ">", ">gv")

	-- Quick fix navigation
	vim.keymap.set("n", "<leader>qf", "<cmd>copen<cr>", { desc = "Open quickfix list" })
	vim.keymap.set("n", "<leader>qc", "<cmd>cclose<cr>", { desc = "Close quickfix list" })
	vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
	vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix" })

	-- Location list navigation
	vim.keymap.set("n", "<leader>ll", "<cmd>lopen<cr>", { desc = "Open location list" })
	vim.keymap.set("n", "<leader>lc", "<cmd>lclose<cr>", { desc = "Close location list" })
	vim.keymap.set("n", "]l", "<cmd>lnext<cr>", { desc = "Next location" })
	vim.keymap.set("n", "[l", "<cmd>lprev<cr>", { desc = "Previous location" })
end)
