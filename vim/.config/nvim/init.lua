local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "

-- Avoid creating swap files in case lazy fails to load
vim.cmd(":set noswapfile")

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})

-- Add lazy to runtimepath
vim.opt.rtp:prepend(lazypath)

require("remap")
require("lazy").setup(require("plugins"))
require("set")
require("colors")
