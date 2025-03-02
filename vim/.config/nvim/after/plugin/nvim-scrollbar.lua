require("scrollbar").setup({
	handlers = {
		cursor = true,
		diagnostic = true,
		gitsigns = true,
		handle = true,
		search = false, -- Requires hlslens
		ale = false, -- Requires ALE
	},
})
