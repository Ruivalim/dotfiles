table.insert(plugins, {
	"windwp/nvim-ts-autotag",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
			per_filetype = {
				["html"] = {
					enable_close = false,
				},
			},
		})
	end,
})

table.insert(plugins, {
	"maxmellon/vim-jsx-pretty",
	ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
})

table.insert(plugins, {
	"styled-components/vim-styled-components",
	branch = "main",
	ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
})

table.insert(plugins, {
	"David-Kunz/react-extract.nvim",
	ft = { "javascriptreact", "typescriptreact" },
	config = function()
		require("react-extract").setup()
	end,
})

table.insert(plugins, {
	"napmn/react-extract.nvim",
	ft = { "javascriptreact", "typescriptreact" },
	config = function()
		require("react-extract").setup()
	end,
})

table.insert(after_load, function()
	-- Enhanced React/JSX settings
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		callback = function()
			-- Enable JSX syntax highlighting
			vim.bo.syntax = "javascript.jsx"

			-- Set local options for React development
			vim.bo.tabstop = 2
			vim.bo.shiftwidth = 2
			vim.bo.softtabstop = 2
			vim.bo.expandtab = true

			-- Enable emmet for JSX
			vim.g.user_emmet_settings = {
				javascript = {
					extends = "jsx",
				},
				typescript = {
					extends = "tsx",
				},
			}
		end,
	})

	-- React component extraction keybindings
	vim.keymap.set(
		{ "v" },
		"<Leader>re",
		":ReactExtractComponentToFile<CR>",
		{ desc = "Extract React component to file" }
	)

	vim.keymap.set(
		{ "v" },
		"<Leader>rc",
		":ReactExtractComponent<CR>",
		{ desc = "Extract React component" }
	)
end)