plugins = {}
after_load = {}

require("plugins.telescope")
require("plugins.oil")
require("plugins.which-key")
require("plugins.illuminate")
require("plugins.lsp")
require("plugins.lualine")
require("plugins.delimitmate")
require("plugins.barbar")
require("plugins.gitsigns")
require("plugins.themes")
require("plugins.vim-cool")
require("plugins.treesitter")
require("plugins.yaml")
require("plugins.coerce")
require("plugins.coop")
require("plugins.smear-cursor")
require("plugins.flash")
require("plugins.neoformat")
require("plugins.fzf")
require("plugins.cmp")
require("plugins.nvim-search-and-replace")
require("plugins.global-note")
require("plugins.notify")
require("plugins.supermaven")
require("plugins.webdav")
require("plugins.render-markdown")
require("plugins.vim-css-color")
require("plugins.emmet")
require("plugins.tailwind")
require("plugins.diagnostics")
require("plugins.snippets")
require("plugins.react")
require("plugins.navigation")
require("plugins.dashboard")
require("plugins.scrollbar")
require("plugins.origami")

require("lazy").setup(plugins, {
	rocks = {
		enabled = false,
	},
})

for _, f in ipairs(after_load) do
	f()
end
