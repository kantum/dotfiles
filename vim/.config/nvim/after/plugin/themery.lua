require("themery").setup({
	themes = {
		{
			name = "gruvbox",
			colorscheme = "gruvbox",
		},
		{
			name = "onedark",
			colorscheme = "onedark",
		},
	},
})

require("themery").setup({
	themes = { "gruvbox", "onedark" }, -- Your list of installed colorschemes
	themeConfigFile = "~/.config/nvim/lua/colors.lua", -- Described below
	livePreview = true, -- Apply theme while browsing. Default to true.
})
