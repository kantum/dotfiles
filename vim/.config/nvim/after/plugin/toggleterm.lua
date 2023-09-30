require("toggleterm").setup({})

-- TODO this is not real toggles
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
local gitui = Terminal:new({ cmd = "gitui", hidden = true, direction = "float" })
local btm = Terminal:new({ cmd = "btm", hidden = true, direction = "float" })

-- function _gitui_toggle()
-- 	gitui:toggle()
-- end

local float = Terminal:new({ cmd = "zsh", hidden = true, direction = "float" })

function _float_toggle()
	float:toggle()
end

local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })

function _lazydocker_toggle()
	lazydocker:toggle()
end

function _btm_toggle()
	btm:toggle()
end

