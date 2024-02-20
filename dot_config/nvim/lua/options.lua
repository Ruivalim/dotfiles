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

vim.opt.undofile = true
vim.opt.undodir = "/Users/ruivalim/.undo_history"

local group = vim.api.nvim_create_augroup("fmt", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	group = group,
	pattern = "*",
	callback = function()
		vim.cmd("Neoformat")
	end,
})
