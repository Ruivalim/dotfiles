table.insert(plugins, {
	"williamboman/mason.nvim",
	opts = {},
})
table.insert(plugins, {
	"williamboman/mason-lspconfig.nvim",
	dependencies = { "neovim/nvim-lspconfig" },
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
			"emmet_language_server",
			"cssls",
			"css_variables",
			"dockerls",
			"jdtls",
			"gopls",
			"bashls",
			"marksman",
		},
		automatic_installation = true,
	},
})
table.insert(plugins, {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	opts = {
		ensure_installed = {
			"stylua",
			"prettier",
			"google-java-format",
		},
	},
})
table.insert(after_load, function()
	vim.lsp.config.lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	}

	vim.lsp.config.ts_ls = {
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
		init_options = {
			preferences = {
				disableSuggestions = false,
				quotePreference = "auto",
				includeCompletionsForModuleExports = true,
				includeCompletionsForImportStatements = true,
				includeCompletionsWithSnippetText = true,
				includeAutomaticOptionalChainCompletions = true,
			},
		},
		on_attach = function(client, bufnr)
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end,
	}

	vim.lsp.config.helm_ls = {
		settings = {
			["helm-ls"] = {
				yamlls = {
					path = "yaml-language-server",
				},
			},
		},
	}

	vim.lsp.config.emmet_language_server = {
		filetypes = {
			"html",
			"css",
			"scss",
			"javascript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"jsp",
		},
	}

	vim.lsp.config.yamlls = {
		settings = {
			yaml = {
				validate = true, -- Precisa estar habilitado para ler configs locais
				hover = true,
				completion = true,
				format = {
					enable = true,
				},
				schemaStore = {
					enable = false, -- Desabilita schemas automáticos da store
					url = "", -- Desabilita URL padrão
				},
				schemas = {}, -- Vazio, mas permite configs locais
				customTags = {}, -- Permite tags customizadas se definidas localmente
			},
		},
	}

	vim.lsp.config.svelte = {
		settings = {
			svelte = {
				plugin = {
					svelte = {
						compilerWarnings = {
							["a11y-missing-attribute"] = "ignore",
						},
					},
				},
			},
		},
		on_attach = function(client, bufnr)
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = { "*.js", "*.ts" },
				callback = function(ctx)
					client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
				end,
			})
		end,
	}
end)

table.insert(plugins, {
	"mfussenegger/nvim-jdtls",
	ft = "java",
})
