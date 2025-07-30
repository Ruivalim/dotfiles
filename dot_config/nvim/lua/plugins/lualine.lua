table.insert(plugins, {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		sections = {
			lualine_c = {
				{
					function()
						local bufname = vim.api.nvim_buf_get_name(0)

						if vim.bo.filetype == "oil" then
							local oil_dir = bufname:match("^oil://(.+)$")
							if oil_dir then
								local cwd = vim.fn.getcwd()
								local relative_path = vim.fn.fnamemodify(oil_dir, ":.")
								local project_name = vim.fn.fnamemodify(cwd, ":t")
								return project_name .. "/" .. relative_path
							end
						end

						if bufname ~= "" then
							local cwd = vim.fn.getcwd()
							local project_name = vim.fn.fnamemodify(cwd, ":t")
							local relative_path = vim.fn.fnamemodify(bufname, ":.")

							relative_path = relative_path:gsub("^%./", "")

							return project_name .. "/" .. relative_path
						end

						return "[No Name]"
					end,
					icon = "",
				},
			},
			lualine_z = {
				"location",
				{
					function()
						return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
					end,
					icon = "🏠",
				},
			},
		},
	},
})
