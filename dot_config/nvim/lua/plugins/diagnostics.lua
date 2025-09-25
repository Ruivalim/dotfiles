table.insert(plugins, {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		focus = true,
		auto_preview = true,
		auto_fold = false,
		auto_open = false,
		auto_close = true,
		padding = true,
		height = 10,
		use_diagnostic_signs = true,
		action_keys = {
			close = "q",
			cancel = "<esc>",
			refresh = "r",
			jump = { "<cr>", "<tab>" },
			open_split = { "<c-x>" },
			open_vsplit = { "<c-v>" },
			open_tab = { "<c-t>" },
			jump_close = { "o" },
			toggle_mode = "m",
			toggle_preview = "P",
			hover = "K",
			preview = "p",
			close_folds = { "zM", "zm" },
			open_folds = { "zR", "zr" },
			toggle_fold = { "zA", "za" },
			previous = "k",
			next = "j",
		},
	},
})

table.insert(plugins, {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	config = function()
		require("lsp_lines").setup()
		-- Disable virtual_text since it's redundant due to lsp_lines
		vim.diagnostic.config({
			virtual_text = false,
		})
	end,
})

table.insert(after_load, function()
	-- Enhanced diagnostic configuration
	vim.diagnostic.config({
		virtual_text = false, -- Disabled because we use lsp_lines
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
			focusable = false,
		},
	})

	-- Custom diagnostic signs using the modern API
	local signs = {
		Error = " ",
		Warn = " ",
		Hint = "󰠠 ",
		Info = " ",
	}

	-- Configure diagnostic signs using the modern vim.diagnostic.config API
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = signs.Error,
				[vim.diagnostic.severity.WARN] = signs.Warn,
				[vim.diagnostic.severity.INFO] = signs.Info,
				[vim.diagnostic.severity.HINT] = signs.Hint,
			},
		},
	})

	-- Auto-show diagnostics on cursor hold
	vim.api.nvim_create_autocmd("CursorHold", {
		callback = function()
			local opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always",
				prefix = " ",
				scope = "cursor",
			}
			vim.diagnostic.open_float(nil, opts)
		end,
	})
end)