table.insert(plugins, {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"saadparwaiz1/cmp_luasnip",
	},
})

table.insert(plugins, {
	"rafamadriz/friendly-snippets",
})

table.insert(after_load, function()
	local luasnip = require("luasnip")

	-- Load friendly-snippets
	require("luasnip.loaders.from_vscode").lazy_load()

	-- Custom React/TypeScript snippets
	luasnip.add_snippets("typescriptreact", {
		luasnip.snippet("rfc", {
			luasnip.text_node("import React from 'react';"),
			luasnip.text_node({ "", "", "interface " }),
			luasnip.insert_node(1, "ComponentName"),
			luasnip.text_node("Props {"),
			luasnip.text_node({ "", "  " }),
			luasnip.insert_node(2, "// props here"),
			luasnip.text_node({ "", "}", "", "" }),
			luasnip.text_node("const "),
			luasnip.insert_node(3, "ComponentName"),
			luasnip.text_node(": React.FC<"),
			luasnip.insert_node(4, "ComponentName"),
			luasnip.text_node("Props> = ({ "),
			luasnip.insert_node(5, "props"),
			luasnip.text_node(" }) => {"),
			luasnip.text_node({ "", "  return (" }),
			luasnip.text_node({ "", "    <div>" }),
			luasnip.text_node({ "", "      " }),
			luasnip.insert_node(6, "// component content"),
			luasnip.text_node({ "", "    </div>" }),
			luasnip.text_node({ "", "  );" }),
			luasnip.text_node({ "", "};" }),
			luasnip.text_node({ "", "", "export default " }),
			luasnip.insert_node(7, "ComponentName"),
			luasnip.text_node(";"),
		}),

		luasnip.snippet("useState", {
			luasnip.text_node("const ["),
			luasnip.insert_node(1, "state"),
			luasnip.text_node(", set"),
			luasnip.function_node(function(args)
				local name = args[1][1]
				return name:gsub("^%l", string.upper)
			end, { 1 }),
			luasnip.text_node("] = useState"),
			luasnip.choice_node(2, {
				luasnip.text_node("<"),
				luasnip.text_node("<string>"),
				luasnip.text_node("<number>"),
				luasnip.text_node("<boolean>"),
			}),
			luasnip.text_node("("),
			luasnip.insert_node(3, "initialValue"),
			luasnip.text_node(");"),
		}),

		luasnip.snippet("useEffect", {
			luasnip.text_node("useEffect(() => {"),
			luasnip.text_node({ "", "  " }),
			luasnip.insert_node(1, "// effect logic"),
			luasnip.text_node({ "", "}, [" }),
			luasnip.insert_node(2, "dependencies"),
			luasnip.text_node("]);"),
		}),
	})

	-- Keybindings for snippets
	vim.keymap.set({ "i", "s" }, "<C-k>", function()
		if luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		end
	end, { silent = true })

	vim.keymap.set({ "i", "s" }, "<C-j>", function()
		if luasnip.jumpable(-1) then
			luasnip.jump(-1)
		end
	end, { silent = true })

	vim.keymap.set("i", "<C-l>", function()
		if luasnip.choice_active() then
			luasnip.change_choice(1)
		end
	end)
end)