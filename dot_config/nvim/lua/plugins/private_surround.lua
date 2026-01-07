-- nvim-surround - Manipulate surroundings
table.insert(plugins, {
	"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	opts = {},
})

-- Usage:
-- ys{motion}{char} - Add surround (e.g., ysiw" adds quotes around word)
-- ds{char}         - Delete surround (e.g., ds" removes quotes)
-- cs{old}{new}     - Change surround (e.g., cs"' changes " to ')
--
-- Examples:
-- ysiw)  - Surround word with ()
-- yss"   - Surround entire line with "
-- ds]    - Delete surrounding []
-- cs'"   - Change ' to "
