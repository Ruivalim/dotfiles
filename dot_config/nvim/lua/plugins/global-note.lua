local get_project_name = function()
	local project_directory, err = vim.loop.cwd()
	if project_directory == nil then
		vim.notify(err, vim.log.levels.WARN)
		return nil
	end

	local project_name = vim.fs.basename(project_directory)
	if project_name == nil then
		vim.notify("Unable to get the project name", vim.log.levels.WARN)
		return nil
	end

	return project_name
end

table.insert(plugins, {
	"backdround/global-note.nvim",
	opts = {
		additional_presets = {
			vim = {
				filename = "vim-reminders.md",
				title = "VIM Commands",
				command_name = "VIMCommands",
				directory = "~/.config/nvim/notes",
			},
			project_local = {
				command_name = "ProjectNote",

				filename = function()
					return get_project_name() .. ".md"
				end,

				title = "Project note",
			},
		},
	},
})
