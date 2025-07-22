table.insert(plugins, {
	"williamboman/mason.nvim",
	opts = {},
})

table.insert(plugins, {
	"williamboman/mason-lspconfig.nvim",
	opts = {
		ensure_installed = {
			"lua_ls",
			"pylsp",
			"rust_analyzer",
			"ts_ls",
			"vimls",
			"taplo",
			"helm_ls",
			"yamlls",
			"svelte",
		},
	},
})

table.insert(plugins, {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	opts = {
		ensure_installed = { "stylua", "prettier" },
	},
})

table.insert(plugins, {
	"neovim/nvim-lspconfig",
})

table.insert(after_load, function()
	local lspconfig = require("lspconfig")

	lspconfig.lua_ls.setup({
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	})
	lspconfig.pylsp.setup({})
	lspconfig.rust_analyzer.setup({})
	lspconfig.ts_ls.setup({})
	lspconfig.vimls.setup({})
	lspconfig.taplo.setup({})
	lspconfig.helm_ls.setup({
		settings = {
			["helm-ls"] = {
				yamlls = {
					path = "yaml-language-server",
				},
			},
		},
	})
	lspconfig.svelte.setup({})
	lspconfig.yamlls.setup({})

	vim.opt.completeopt = "menu,menuone,noselect"
end)
