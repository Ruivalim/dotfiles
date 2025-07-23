vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("options")
require("plugins")
require("mappings")

local ok, theme_content = pcall(function()
	local theme_file = io.open(vim.fn.expand("~/.config/themes/current-theme"), "r")
	if theme_file then
		local theme = theme_file:read("*line")
		theme_file:close()
		return theme
	end
	return nil
end)

if ok and theme_content then
	theme_content = theme_content:gsub("%s+", "")
	-- Validate theme name (alphanumeric, dash, underscore only)
	if theme_content:match("^[%w_-]+$") then
		local theme_ok = pcall(vim.cmd.colorscheme, theme_content)
		if not theme_ok then
			vim.cmd.colorscheme("default")
			vim.notify("Failed to load theme '" .. theme_content .. "', using default", vim.log.levels.WARN)
		end
	else
		vim.cmd.colorscheme("default")
		vim.notify("Invalid theme name, using default", vim.log.levels.WARN)
	end
else
	vim.cmd.colorscheme("default")
end

-- disable precognition from start
require("precognition").toggle()

-- disable markdown render from start
require("render-markdown").toggle()
