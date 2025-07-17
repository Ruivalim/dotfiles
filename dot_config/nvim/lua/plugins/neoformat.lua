table.insert(plugins, {
	"sbdchd/neoformat",
	cmd = { "Neoformat" },
	config = function()
		-- vim.g.neoformat_verbose = 1
		vim.g.neoformat_basic_format_align = 1
		vim.g.neoformat_basic_format_retab = 1
		vim.g.neoformat_basic_format_trim = 1
		vim.g.neoformat_try_node_exe = 1

		vim.g.neoformat_enabled_javascript = { "prettier", "eslint" }
		vim.g.neoformat_enabled_typescript = { "prettier", "eslint" }
		vim.g.neoformat_enabled_html = { "prettier", "htmlbeautify", "tidy" }
		vim.g.neoformat_enabled_css = { "prettier", "stylelint" }
		vim.g.neoformat_enabled_scss = { "prettier", "stylelint" }
		vim.g.neoformat_enabled_json = { "prettier", "jq" }
		vim.g.neoformat_enabled_markdown = { "prettier" }
		vim.g.neoformat_enabled_yaml = { "prettier" }
		vim.g.neoformat_enabled_vue = { "prettier" }
		vim.g.neoformat_enabled_jsx = { "prettier" }
		vim.g.neoformat_enabled_tsx = { "prettier" }
		vim.g.neoformat_enabled_jsp = { "htmlbeautify", "tidy" }

		vim.g.neoformat_html_prettier = {
			exe = "prettier",
			args = {
				"--stdin-filepath",
				"%:p",
				"--parser",
				"html",
				"--print-width",
				"120",
				"--tab-width",
				"2",
				"--use-tabs",
				"false",
				"--semi",
				"true",
				"--single-quote",
				"false",
				"--bracket-spacing",
				"true",
				"--bracket-same-line",
				"false",
				"--html-whitespace-sensitivity",
				"css",
			},
			stdin = 1,
		}

		vim.g.neoformat_javascript_prettier = {
			exe = "prettier",
			args = {
				"--stdin-filepath",
				"%:p",
				"--print-width",
				"120",
				"--tab-width",
				"2",
				"--use-tabs",
				"false",
				"--semi",
				"true",
				"--single-quote",
				"true",
				"--trailing-comma",
				"es5",
			},
			stdin = 1,
		}

		vim.g.neoformat_css_prettier = {
			exe = "prettier",
			args = {
				"--stdin-filepath",
				"%:p",
				"--parser",
				"css",
				"--print-width",
				"120",
				"--tab-width",
				"2",
				"--use-tabs",
				"false",
				"--semi",
				"true",
				"--single-quote",
				"false",
			},
			stdin = 1,
		}

		vim.g.neoformat_json_prettier = {
			exe = "prettier",
			args = {
				"--stdin-filepath",
				"%:p",
				"--parser",
				"json",
				"--print-width",
				"120",
				"--tab-width",
				"2",
				"--use-tabs",
				"false",
			},
			stdin = 1,
		}

		vim.g.neoformat_jsp_htmlbeautify = {
			exe = "html-beautify",
			args = { "--indent-size", "4", "--wrap-line-length", "160", "--preserve-newlines", "--end-with-newline" },
			stdin = 1,
		}

		vim.g.neoformat_jsp_tidy = {
			exe = "tidy",
			args = {
				"-q",
				"--tidy-mark",
				"no",
				"--show-warnings",
				"no",
				"--indent",
				"yes",
				"--indent-spaces",
				"2",
				"--wrap",
				"120",
			},
			stdin = 1,
		}

		local function check_prettier()
			local handle = io.popen("which prettier 2>/dev/null")
			local result = handle:read("*a")
			handle:close()
			return result ~= ""
		end

		local function check_html_beautify()
			local handle = io.popen("which html-beautify 2>/dev/null")
			local result = handle:read("*a")
			handle:close()
			return result ~= ""
		end

		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = "*.jsp",
			callback = function()
				vim.bo.filetype = "jsp"
				vim.cmd("set syntax=html")
			end,
		})

		local function setup_auto_format()
			local cwd = vim.fn.getcwd()
			local package_json = cwd .. "/package.json"
			local prettier_config = cwd .. "/.prettierrc"

			-- Se existe package.json ou .prettierrc, ativar auto-formatação
			if vim.fn.filereadable(package_json) == 1 or vim.fn.filereadable(prettier_config) == 1 then
				vim.api.nvim_create_autocmd("BufWritePre", {
					pattern = {
						"*.js",
						"*.jsx",
						"*.ts",
						"*.tsx",
						"*.html",
						"*.css",
						"*.scss",
						"*.json",
						"*.md",
						"*.vue",
						"*.jsp",
					},
					callback = function()
						vim.cmd("silent! Neoformat")
					end,
					buffer = vim.api.nvim_get_current_buf(),
				})
			end
		end

		vim.api.nvim_create_autocmd("BufEnter", {
			callback = setup_auto_format,
		})
	end,
})
