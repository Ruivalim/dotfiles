plugins = {}
after_load = {}

-- Core plugins
require("plugins.telescope")
require("plugins.oil")
require("plugins.neo-tree")
require("plugins.illuminate")
require("plugins.lsp")
require("plugins.lualine")
require("plugins.barbar")
require("plugins.gitsigns")
require("plugins.themes")
require("plugins.treesitter")
require("plugins.yaml")
require("plugins.smear-cursor")
require("plugins.neoformat")
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
require("plugins.react")
require("plugins.navigation")
require("plugins.scrollbar")
require("plugins.origami")

-- New plugins
require("plugins.harpoon")
require("plugins.todo-comments")
require("plugins.noice")
require("plugins.indent-blankline")
require("plugins.dressing")
require("plugins.autopairs")
require("plugins.comment")
require("plugins.visual-multi")
require("plugins.neogit")
require("plugins.surround")
require("plugins.mini-ai")
require("plugins.lsp-signature")
require("plugins.glance")
require("plugins.project")
require("plugins.fidget")
require("plugins.inlay-hints")

require("lazy").setup(plugins, {
	rocks = {
		enabled = false,
	},
})

for _, f in ipairs(after_load) do
	f()
end
