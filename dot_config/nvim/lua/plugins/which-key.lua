table.insert(plugins, {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		require("which-key").setup({
			plugins = {
				marks = false,
				registers = false,
				spelling = {
					enabled = true,
					suggestions = 20,
				},
				presets = {
					operators = false,
					motions = false,
					text_objects = false,
					windows = false,
					nav = false,
					z = false,
					g = false,
				},
			},
		})
	end,
})

local which_key_timer = nil
local delay_ms = 500

local function cancel_which_key_timer()
	if which_key_timer then
		vim.loop.timer_stop(which_key_timer)
		which_key_timer = nil
	end
end

local function trigger_which_key()
	cancel_which_key_timer()
	which_key_timer = vim.loop.new_timer()
	which_key_timer:start(
		delay_ms,
		0,
		vim.schedule_wrap(function()
			require("which-key").show()
			which_key_timer = nil
		end)
	)
end

_G.trigger_which_key = trigger_which_key
_G.cancel_which_key_timer = cancel_which_key_timer
