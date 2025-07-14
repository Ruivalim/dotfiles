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

-- Auto-load theme based on current-theme file
local theme_file = io.open(vim.fn.expand("~/.config/themes/current-theme"), "r")
if theme_file then
    local theme = theme_file:read("*line")
    theme_file:close()
    
    if theme then
        theme = theme:gsub("%s+", "") -- trim whitespace
        vim.cmd.colorscheme(theme)
    end
end
