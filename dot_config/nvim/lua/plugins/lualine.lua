table.insert(plugins, {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			globalstatus = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				{ "branch", icon = "" },
				{
					"diff",
					symbols = { added = " ", modified = " ", removed = " " },
				},
				"diagnostics",
			},
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
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
})
