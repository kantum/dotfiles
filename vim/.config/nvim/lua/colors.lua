require("onedarkpro").setup({
	options = {
		transparency = true,
	},
})

require("gruvbox").setup({
	overrides = {
		MatchParen = { bg = "none", fg = "#ff9900" },
	},
	transparent_mode = true,
})

-- Themery block
-- This block will be replaced by Themery.
vim.cmd("colorscheme onedark")
vim.g.theme_id = 2
-- end themery block
