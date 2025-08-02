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
		preview = {
			filesize_limit = 10, -- Limit the size of files to preview
			mime_hook = function(filepath, bufnr, opts)
				local is_image = function(filepath)
					local image_extensions = { "png", "jpg" } -- Supported image formats
					local split_path = vim.split(filepath:lower(), ".", { plain = true })
					local extension = split_path[#split_path]
					return vim.tbl_contains(image_extensions, extension)
				end
				if is_image(filepath) then
					local term = vim.api.nvim_open_term(bufnr, {})
					local function send_output(_, data, _)
						for _, d in ipairs(data) do
							vim.api.nvim_chan_send(term, d .. "\r\n")
						end
					end
					vim.fn.jobstart({
						"catimg",
						filepath, -- Terminal image viewer command
					}, { on_stdout = send_output, stdout_buffered = true, pty = true })
				else
					require("telescope.previewers.utils").set_preview_message(
						bufnr,
						opts.winid,
						"Binary cannot be previewed"
					)
				end
			end,
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

local config_path = "~/git/dotfiles/vim/.config/"
vim.keymap.set("n", "<leader>fi", function()
	builtin.live_grep({ cwd = config_path })
end, telescope_options)

vim.keymap.set("v", "<leader>fi", function()
	local text = vim.getVisualSelection()
	builtin.find_files({ default_text = text, cwd = config_path })
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
