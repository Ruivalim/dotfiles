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
			"tailwindcss",
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

	vim.lsp.config.jdtls = {
		settings = {
			java = {
				eclipse = {
					downloadSources = true,
				},
				configuration = {
					updateBuildConfiguration = "interactive",
				},
				maven = {
					downloadSources = true,
				},
				implementationsCodeLens = {
					enabled = true,
				},
				referencesCodeLens = {
					enabled = true,
				},
				references = {
					includeDecompiledSources = true,
				},
				format = {
					enabled = true,
					settings = {
						url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
						profile = "GoogleStyle",
					},
				},
			},
			signatureHelp = { enabled = true },
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
			},
			contentProvider = { preferred = "fernflower" },
			extendedClientCapabilities = {
				progressReportProvider = false,
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				useBlocks = true,
			},
		},
	}

	vim.opt.completeopt = "menu,menuone,noselect"
end)
