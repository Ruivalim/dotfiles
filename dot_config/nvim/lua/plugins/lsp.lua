table.insert(plugins, {
	"williamboman/mason.nvim",
	opts = {},
})

table.insert(plugins, {
	"williamboman/mason-lspconfig.nvim",
	opts = {
		ensure_installed = { "lua_ls", "pylsp", "rust_analyzer", "ts_ls", "vimls", "taplo", "helm_ls", "yamlls" },
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

table.insert(plugins, {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"onsails/lspkind-nvim",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-omni",
		"hrsh7th/cmp-emoji",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
	},
})

table.insert(plugins, {
	"sbdchd/neoformat",
	cmd = { "Neoformat" },
})

table.insert(after_load, function()
	local lspconfig = require("lspconfig")

	lspconfig.lua_ls.setup({})
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

	lspconfig.yamlls.setup({})

	vim.opt.completeopt = "menu,menuone,noselect"

	local cmp = require("cmp")
	local luasnip = require("luasnip")

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
			["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
			["<C-e>"] = cmp.mapping.abort(), -- close completion window
			["<CR>"] = cmp.mapping.confirm({ select = false }),
		}),
		-- sources for autocompletion
		sources = cmp.config.sources({
			{ name = "nvim_lsp" }, -- LSP
			{ name = "luasnip" }, -- snippets
			{ name = "buffer" }, -- text within the current buffer
			{ name = "path" }, -- file system paths
		}),
	})
end)
