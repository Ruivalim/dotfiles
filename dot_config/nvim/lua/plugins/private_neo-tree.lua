-- Neo-tree - Visual file explorer sidebar
table.insert(plugins, {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
			close_if_last_window = false,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			sort_case_insensitive = true,
			open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
			default_component_configs = {
				container = {
					enable_character_fade = true,
				},
				indent = {
					indent_size = 2,
					padding = 1,
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					default = "*",
					highlight = "NeoTreeFileIcon",
				},
				modified = {
					symbol = "[+]",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
				git_status = {
					symbols = {
						added = "+",
						modified = "~",
						deleted = "-",
						renamed = "➜",
						untracked = "?",
						ignored = "◌",
						unstaged = "✗",
						staged = "✓",
						conflict = "",
					},
				},
			},
			window = {
				position = "left",
				width = 35,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["<space>"] = "none",
					["<2-LeftMouse>"] = "open",
					["<cr>"] = "open",
					["o"] = "open",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["t"] = "open_tabnew",
					["w"] = "open_with_window_picker",
					["C"] = "close_node",
					["z"] = "close_all_nodes",
					["Z"] = "expand_all_nodes",
					["a"] = {
						"add",
						config = {
							show_path = "relative",
						},
					},
					["A"] = "add_directory",
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
					["P"] = { "toggle_preview", config = { use_float = true } },
					["l"] = "open",
					["h"] = "close_node",
				},
			},
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = {
						"node_modules",
						".git",
					},
					never_show = {
						".DS_Store",
						"thumbs.db",
					},
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
				},
				group_empty_dirs = false,
				hijack_netrw_behavior = "disabled",
				use_libuv_file_watcher = true,
			},
			buffers = {
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
				},
				group_empty_dirs = true,
				show_unloaded = true,
			},
			git_status = {
				window = {
					position = "float",
				},
			},
		})

		-- Auto-open Neo-tree on startup
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				vim.defer_fn(function()
					vim.cmd("Neotree show")
				end, 10)
			end,
		})

		-- Close vim if Neo-tree is the last window
		vim.api.nvim_create_autocmd("WinClosed", {
			nested = true,
			callback = function()
				-- Defer to let the window actually close first
				vim.defer_fn(function()
					local wins = vim.api.nvim_list_wins()
					local non_tree = 0
					for _, w in ipairs(wins) do
						local buf = vim.api.nvim_win_get_buf(w)
						local ft = vim.bo[buf].filetype
						local is_floating = vim.api.nvim_win_get_config(w).relative ~= ""
						if not is_floating and ft ~= "neo-tree" then
							non_tree = non_tree + 1
						end
					end
					if non_tree == 0 then
						vim.cmd("qa!")
					end
				end, 10)
			end,
		})
	end,
})
