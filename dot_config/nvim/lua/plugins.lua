plugins = {}
after_load = {}

require("plugins.telescope")
require("plugins.oil")
require("plugins.which-key")
require("plugins.illuminate")
require("plugins.lsp")
require("plugins.lualine")
require("plugins.delimitmate")
require("plugins.mundo")
require("plugins.barbar")
require("plugins.gitsigns")
require("plugins.helm")
require("plugins.rose-pine")
require("plugins.vim-cool")
require("plugins.treesitter")
require("plugins.yaml")
require("plugins.toggleterm")
require("plugins.coerce")
require("plugins.coop")
require("plugins.smear-cursor")
require("plugins.flash")
require("plugins.coc")
require("plugins.neoformat")
require("plugins.fzf")
require("plugins.gruvbox")
require("plugins.copilot")
require("plugins.nvim-search-and-replace")
require("plugins.precognition")
require("plugins.auto-session")
require("plugins.global-note")

require("lazy").setup(plugins)

for _, f in ipairs(after_load) do
	f()
end
