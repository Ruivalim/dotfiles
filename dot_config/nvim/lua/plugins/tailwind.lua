table.insert(plugins, {
	"luckasRanarison/tailwind-tools.nvim",
	name = "tailwind-tools",
	build = ":UpdateRemotePlugins",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		document_color = {
			enabled = true,
			kind = "inline",
			inline_symbol = "󰝤 ",
			debounce = 200,
		},
		conceal = {
			enabled = false,
		},
		custom_filetypes = {
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
		},
	},
})

table.insert(after_load, function()
	-- Enhanced Tailwind CSS LSP configuration
	vim.lsp.config.tailwindcss = {
		cmd = { "tailwindcss-language-server", "--stdio" },
		filetypes = {
			"html",
			"css",
			"scss",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
		},
		settings = {
			tailwindCSS = {
				experimental = {
					classRegex = {
						"tw`([^`]*)",
						"tw=\"([^\"]*)",
						"tw={\"([^\"}]*)",
						"tw\\.\\w+`([^`]*)",
						"tw\\(.*?\\)`([^`]*)",
						{ "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
						{ "classnames\\(([^)]*)\\)", "'([^']*)'" },
						{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
						{ "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
					},
				},
				validate = true,
				lint = {
					cssConflict = "warning",
					invalidApply = "error",
					invalidConfigPath = "error",
					invalidScreen = "error",
					invalidTailwindDirective = "error",
					invalidVariant = "error",
					recommendedVariantOrder = "warning",
				},
			},
		},
	}
end)