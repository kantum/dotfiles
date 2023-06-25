local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
source ~/.vimrc
]])

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = function() local ts_update = require('nvim-treesitter.install').update({ with_sync = true }) ts_update() end, }
  use { 'junegunn/fzf.vim', requires = { 'junegunn/fzf', run = ':call fzf#install()' } }
  use { 'junegunn/goyo.vim' } -- Distraction free plugin
  use { 'junegunn/vim-plug' } -- Plugin manager
  use { 'tpope/vim-fugitive' } -- git plugin
  use { 'tpope/vim-commentary' } -- Comment plugin
  use { 'navarasu/onedark.nvim' } -- Onedark colorscheme
  use { 'tribela/vim-transparent' } -- Transparent background
  use { 'nvim-lualine/lualine.nvim' } -- Statusline
  use { 'nvim-tree/nvim-web-devicons' } -- Statusline icons
  use { 'ap/vim-css-color' } -- Css colors show in code
  use { 'mbbill/undotree' } -- Undo tree
  use { 'aspeddro/gitui.nvim' }
  use { 'github/copilot.vim' } -- Copilot
  use { 'editorconfig/editorconfig-vim' } -- Editorconfig
  use { 'rust-lang/rust.vim' } -- Rust
  use { 'neoclide/coc.nvim', branch= 'release'} -- Coc
  use { 'fatih/vim-go', run = ':GoUpdateBinaries' } -- Go
  use { "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end } -- Markdown preview


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
	  require('packer').sync()
  end
end)
