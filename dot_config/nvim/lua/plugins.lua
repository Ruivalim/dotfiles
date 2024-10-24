plugins = {}
after_load = {}

require("plugins.telescope")
require("plugins.oil")
require("plugins.which-key")
require("plugins.tokyonight")
require("plugins.illuminate")
require("plugins.lsp")
require("plugins.lualine")
require("plugins.delimitmate")
require("plugins.mundo")
require("plugins.barbar")
require("plugins.gitsigns")
require("plugins.helm")

require("lazy").setup(plugins)

for _, f in ipairs(after_load) do
	f()
end
