-- project.nvim - Project management with auto session
table.insert(plugins, {
	"ahmedkhalf/project.nvim",
	config = function()
		require("project_nvim").setup({
			manual_mode = false,
			detection_methods = { "lsp", "pattern" },
			patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Cargo.toml" },
			ignore_lsp = {},
			exclude_dirs = { "~/.cargo/*", "*/node_modules/*" },
			show_hidden = false,
			silent_chdir = true,
			scope_chdir = "global",
			datapath = vim.fn.stdpath("data"),
		})

		-- Telescope integration
		require("telescope").load_extension("projects")
	end,
})

-- Auto-session - Automatically save and restore sessions
table.insert(plugins, {
	"rmagatti/auto-session",
	lazy = false,
	opts = {
		log_level = "error",
		auto_session_enable_last_session = false,
		auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
		auto_session_enabled = true,
		auto_save_enabled = true,
		auto_restore_enabled = true,
		auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
		auto_session_use_git_branch = true,
		bypass_session_save_file_types = { "neo-tree", "oil", "toggleterm" },
	},
})
