local uname = vim.loop.os_uname().sysname

vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.opt.undofile = true

if uname == "Darwin" then
	vim.opt.undodir = "/Users/ruivalim/.undo_history"
elseif uname == "Linux" then
	vim.opt.undodir = "/home/ruivalim/.undo_history"
end

local group = vim.api.nvim_create_augroup("fmt", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	group = group,
	pattern = "*",
	callback = function()
		vim.cmd("Neoformat")
	end,
})
