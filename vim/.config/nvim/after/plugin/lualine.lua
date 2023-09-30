require('lualine').setup {
	sections = {
		lualine_x = {
			{
				function() return require("copilot_status").status_string() end,
				cnd = function() return require("copilot_status").enabled() end,
			}
		}
	}
}
