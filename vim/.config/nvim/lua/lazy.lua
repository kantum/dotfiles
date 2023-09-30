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

-- Add lazy to runtimepath
vim.opt.rtp:prepend(lazypath)
