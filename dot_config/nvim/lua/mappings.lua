vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- <c-p> on oil to preview file
-- :vplit to vertical split
-- :split to horizontal split
-- <c-w> + hjkl to move between splits
-- <c-w> + +-<> to resize splits
function _G.check_back_space()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", {})
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", {})
vim.api.nvim_set_keymap("n", "s", '<cmd>lua require("flash").jump()<cr>', {})

-- COC Configs
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
vim.api.nvim_set_keymap(
	"i",
	"<TAB>",
	'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
	opts
)
vim.api.nvim_set_keymap("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
vim.api.nvim_set_keymap("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })
vim.api.nvim_set_keymap(
	"i",
	"<cr>",
	[[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
	opts
)
vim.api.nvim_set_keymap("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)", {})
vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", { silent = true })
vim.api.nvim_set_keymap("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
vim.api.nvim_set_keymap("n", "gi", "<Plug>(coc-implementation)", { silent = true })
vim.api.nvim_set_keymap("n", "gr", "<Plug>(coc-references)", { silent = true })

function _G.show_docs()
	local cw = vim.fn.expand("<cword>")
	if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
		vim.api.nvim_command("h " .. cw)
	elseif vim.api.nvim_eval("coc#rpc#ready()") then
		vim.fn.CocActionAsync("doHover")
	else
		vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
	end
end
vim.api.nvim_set_keymap("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })

local wk = require("which-key")

wk.add({
	{ "<leader>b", group = "Buffer", nowait = true, remap = false },
	{ "<leader>bc", "<cmd>BufferClose<cr>", desc = "Close", nowait = true, remap = false },
	{ "<leader>bj", "<cmd>BufferPick<cr>", desc = "Jump", nowait = true, remap = false },
	{ "<leader>bn", "<cmd>BufferNext<cr>", desc = "Next", nowait = true, remap = false },
	{ "<leader>bp", "<cmd>BufferPrevious<cr>", desc = "Previous", nowait = true, remap = false },
	{ "<leader>f", group = "File", nowait = true, remap = false },
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", nowait = true, remap = false },
	{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
	{ "<leader>n", "<cmd>Oil<cr>", desc = "Oil", nowait = true, remap = false },
	{ "<leader>p", group = "Plugins", nowait = true, remap = false },
	{ "<leader>pl", "<cmd>Lazy<cr>", desc = "Lazy", nowait = true, remap = false },
	{ "<leader>pm", "<cmd>Mason<cr>", desc = "Mason", nowait = true, remap = false },
	{ "<leader>u", "<cmd>MundoToggle<cr>", desc = "Mundo Toggle", nowait = true, remap = false },
	{ "<leader>t", group = "Terminal", nowait = true, remap = false },
	{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal", nowait = true, remap = false },
})
