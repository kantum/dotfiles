require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("undo")

-- Add toggle preview
local action_layout = require("telescope.actions.layout")
require("telescope").setup({
	defaults = {
		mappings = {
			n = {
				["<M-p>"] = action_layout.toggle_preview,
			},
			i = {
				["<M-p>"] = action_layout.toggle_preview,
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
		pickers = {
			find_files = {
				hidden = true, -- will still show the inside of `.git/` as it's not `.gitignore`d.
				-- find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "-u" },
			},
		},
		extensions = {
			file_browser = {
				initial_mode = "normal", -- TODO not working
			},
			fzf = {
				fuzzy = true, -- false will only do exact matching
				hidden = true, -- show hidden files
			},
			undo = {},
		},
	},
})

local builtin = require("telescope.builtin")
local telescope_options = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>ff", builtin.find_files, telescope_options)
vim.keymap.set("v", "<leader>ff", function()
	local text = vim.getVisualSelection()
	builtin.find_files({ default_text = text })
end, telescope_options)

vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("v", "<leader>fg", function()
	local text = vim.getVisualSelection()
	builtin.live_grep({ default_text = text })
end, telescope_options)
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("v", "<leader>fb", function()
	local text = vim.getVisualSelection()
	builtin.buffers({ default_text = text })
end, telescope_options)

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

