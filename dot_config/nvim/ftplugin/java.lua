local java_21_home = vim.fn.expand("~/.sdkman/candidates/java/21.0.5-tem")
local java_11_home = vim.fn.expand("~/.sdkman/candidates/java/11.0.26-kona")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

local os_config = "config_mac"
if vim.fn.has("linux") == 1 then
	os_config = "config_linux"
elseif vim.fn.has("win32") == 1 then
	os_config = "config_win"
end

local bundles = {}
local java_test_path = vim.fn.stdpath("data") .. "/mason/packages/java-test"
local java_debug_path = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter"

if vim.fn.isdirectory(java_test_path) == 1 then
	vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n"))
end

if vim.fn.isdirectory(java_debug_path) == 1 then
	vim.list_extend(
		bundles,
		vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n")
	)
end

local config = {
	cmd = {
		java_21_home .. "/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"-Xmx2g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		launcher_jar,
		"-configuration",
		jdtls_path .. "/" .. os_config,
		"-data",
		workspace_dir,
	},

	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

	settings = {
		java = {
			eclipse = { downloadSources = true },
			configuration = {
				updateBuildConfiguration = "interactive",
				runtimes = {
					{ name = "JavaSE-11", path = java_11_home },
					{ name = "JavaSE-21", path = java_21_home, default = true },
				},
			},
			maven = { downloadSources = true },
			implementationsCodeLens = { enabled = true },
			referencesCodeLens = { enabled = true },
			references = { includeDecompiledSources = true },
			format = {
				enabled = true,
				settings = {
					url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
					profile = "GoogleStyle",
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
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
				importOrder = { "java", "javax", "com", "org" },
			},
			contentProvider = { preferred = "fernflower" },
			extendedClientCapabilities = { progressReportProvider = false },
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
	},

	init_options = { bundles = bundles },
	capabilities = require("cmp_nvim_lsp").default_capabilities(),

	on_attach = function(client, bufnr)
		local opts = { buffer = bufnr, silent = true }

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)

		vim.keymap.set("n", "<leader>jo", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
		vim.keymap.set("n", "<leader>jv", "<Cmd>lua require'jdtls'.extract_variable()<CR>", opts)
		vim.keymap.set("v", "<leader>jv", "<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>", opts)
		vim.keymap.set("n", "<leader>jc", "<Cmd>lua require'jdtls'.extract_constant()<CR>", opts)
		vim.keymap.set("v", "<leader>jc", "<Esc><Cmd>lua require'jdtls'.extract_constant(true)<CR>", opts)
		vim.keymap.set("v", "<leader>jm", "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>", opts)
	end,
}

require("jdtls").start_or_attach(config)
