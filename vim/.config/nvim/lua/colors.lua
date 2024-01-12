require("onedarkpro").setup({
	options = {
		transparency = true,
	},
})

require("gruvbox").setup({
	transparent_mode = true,
})

-- Themery block
-- This block will be replaced by Themery.
vim.cmd("colorscheme gruvbox")
vim.g.theme_id = 1
-- end themery block
