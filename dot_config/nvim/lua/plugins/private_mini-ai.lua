-- mini.ai - Better text objects
table.insert(plugins, {
	"echasnovski/mini.ai",
	version = "*",
	event = "VeryLazy",
	opts = {
		n_lines = 500,
		custom_textobjects = nil,
		mappings = {
			around = "a",
			inside = "i",
			around_next = "an",
			inside_next = "in",
			around_last = "al",
			inside_last = "il",
			goto_left = "g[",
			goto_right = "g]",
		},
	},
})

-- Usage:
-- Now you can use "next" and "last" modifiers:
-- cin)  - Change inside NEXT ()
-- cil)  - Change inside LAST ()
-- dan"  - Delete around NEXT "
--
-- Works with all text objects: () [] {} <> "" '' `` and more
