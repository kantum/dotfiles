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
	livePreview = true, -- Apply theme while browsing. Default to true.
})
