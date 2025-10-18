local patterns = { ".git", "package.json", "Cargo.toml", "go.mod", "pyproject.toml", "setup.py", "build.gradle" }

table.insert(plugins, {
	"ahmedkhalf/project.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("project_nvim").setup({
			detection_methods = { "lsp", "pattern" },
			patterns = patterns,
			exclude_dirs = {
				"~/Downloads",
				"~/.cargo/*",
				"~/.local/*",
			},
			show_hidden = false,
			silent_chdir = false,
			datapath = vim.fn.stdpath("data"),
			scope_chdir = "global",
		})

		require("telescope").load_extension("projects")

		-- Auto-discover projects in ~/work recursively
		local function discover_work_projects()
			local work_dir = vim.fn.expand("~/work")
			local max_depth = 5
			local found_projects = {}

			local function scan_directory(dir, depth)
				if depth > max_depth then
					return
				end
				if vim.fn.isdirectory(dir) ~= 1 then
					return
				end

				-- Check if current directory is a project
				local is_project = false
				for _, pattern in ipairs(patterns) do
					local path = dir .. "/" .. pattern
					if vim.fn.isdirectory(path) == 1 or vim.fn.filereadable(path) == 1 then
						is_project = true
						table.insert(found_projects, dir)
						break
					end
				end

				-- If not a project root, scan subdirectories
				if not is_project then
					local ok, handle = pcall(vim.loop.fs_scandir, dir)
					if ok and handle then
						while true do
							local name, type = vim.loop.fs_scandir_next(handle)
							if not name then
								break
							end

							-- Skip hidden directories and common non-project folders
							if
								type == "directory"
								and not name:match("^%.")
								and name ~= "node_modules"
								and name ~= "target"
								and name ~= "dist"
								and name ~= "build"
							then
								scan_directory(dir .. "/" .. name, depth + 1)
							end
						end
					end
				end
			end

			if vim.fn.isdirectory(work_dir) == 1 then
				scan_directory(work_dir, 0)

				-- Get the history file path
				local data_path = vim.fn.stdpath("data")
				local history_path = data_path .. "/project_nvim/project_history"

				-- Read existing projects
				local existing_projects = {}
				if vim.fn.filereadable(history_path) == 1 then
					for line in io.lines(history_path) do
						if line ~= "" then
							table.insert(existing_projects, line)
						end
					end
				end

				-- Add found projects to the beginning (most recent)
				local all_projects = {}
				local seen = {}

				-- Add new found projects first
				for _, project in ipairs(found_projects) do
					if not seen[project] then
						table.insert(all_projects, project)
						seen[project] = true
					end
				end

				-- Add existing projects (avoid duplicates)
				for _, project in ipairs(existing_projects) do
					if not seen[project] and vim.fn.isdirectory(project) == 1 then
						table.insert(all_projects, project)
						seen[project] = true
					end
				end

				-- Write back to history file
				vim.fn.mkdir(vim.fn.fnamemodify(history_path, ":h"), "p")
				local file = io.open(history_path, "w")
				if file then
					for _, project in ipairs(all_projects) do
						file:write(project .. "\n")
					end
					file:close()
				end
			end
		end

		-- Run discovery after telescope extension is loaded
		vim.defer_fn(discover_work_projects, 200)
	end,
})

table.insert(plugins, {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"ahmedkhalf/project.nvim",
	},
	config = function()
		local db = require("dashboard")

		db.setup({
			theme = "hyper",
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
					{
						icon = "  ",
						icon_hl = "@variable",
						desc = "Projects",
						group = "Label",
						action = "Telescope projects",
						key = "p",
					},
					{
						icon = "  ",
						icon_hl = "@variable",
						desc = "Add Project",
						group = "Label",
						action = [[lua vim.ui.input({ prompt = 'Project path: ', default = vim.fn.expand('~'), completion = 'dir' }, function(path) if path then local expanded = vim.fn.expand(path); local data_path = vim.fn.stdpath('data'); local history_path = data_path .. '/project_nvim/project_history'; local existing = {}; if vim.fn.filereadable(history_path) == 1 then for line in io.lines(history_path) do if line ~= '' and line ~= expanded then table.insert(existing, line) end end end; vim.fn.mkdir(vim.fn.fnamemodify(history_path, ':h'), 'p'); local file = io.open(history_path, 'w'); if file then file:write(expanded .. '\n'); for _, proj in ipairs(existing) do file:write(proj .. '\n') end; file:close() end; vim.cmd('cd ' .. expanded); print('Added project: ' .. expanded) end end)]],
						key = "a",
					},
					{
						icon = "  ",
						icon_hl = "@variable",
						desc = "Remove Project",
						group = "Error",
						action = [[lua local data_path = vim.fn.stdpath('data'); local history_path = data_path .. '/project_nvim/project_history'; local projects = {}; if vim.fn.filereadable(history_path) == 1 then for line in io.lines(history_path) do if line ~= '' then table.insert(projects, line) end end end; if #projects == 0 then print('No projects in history') return end; vim.ui.select(projects, { prompt = 'Remove project: ' }, function(choice) if choice then local remaining = {}; for _, proj in ipairs(projects) do if proj ~= choice then table.insert(remaining, proj) end end; local file = io.open(history_path, 'w'); if file then for _, proj in ipairs(remaining) do file:write(proj .. '\n') end; file:close(); print('Removed: ' .. choice) end end end)]],
						key = "r",
					},
					{
						icon = "  ",
						icon_hl = "@variable",
						desc = "Find Files",
						group = "Label",
						action = "Telescope find_files",
						key = "f",
					},
					{
						icon = "  ",
						desc = "Config",
						group = "DiagnosticInfo",
						action = "edit $MYVIMRC | cd %:p:h",
						key = "c",
					},
					{
						icon = "  ",
						desc = "New File",
						group = "DiagnosticWarn",
						action = "enew",
						key = "n",
					},
					{
						icon = "  ",
						desc = "Quit",
						group = "Error",
						action = "quit",
						key = "q",
					},
				},
				project = {
					enable = false,
				},
				mru = {
					limit = 10,
					icon = "  ",
					label = " Recent Files:",
				},
			},
		})
	end,
})
