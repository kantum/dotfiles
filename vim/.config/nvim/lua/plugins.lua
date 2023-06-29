return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.1',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	{ 'nvim-treesitter/nvim-treesitter',
	build = function() local ts_update = require('nvim-treesitter.install').update({ with_sync = true }) ts_update() end, },
	{ 'junegunn/goyo.vim' },
	-- { 'tpope/vim-fugitive' }, -- git plugin
	-- { 'tribela/vim-transparent' }, -- Transparent background
	-- { 'nvim-lualine/lualine.nvim' }, -- Statusline
	{ 'nvim-tree/nvim-web-devicons' }, -- Statusline icons
	-- { 'ap/vim-css-color' }, -- Css colors show in code
	{ 'mbbill/undotree' }, -- Undo tree
	{ 'aspeddro/gitui.nvim' },
	{ 'github/copilot.vim' }, -- Copilot
	-- { 'editorconfig/editorconfig-vim' }, -- Editorconfig
	{ 'rust-lang/rust.vim' }, -- Rust
	-- { 'neoclide/coc.nvim', branch= 'release'}, -- Coc
	{ 'fatih/vim-go', build = ':GoUpdateBinaries' }, -- Go
	{ 'iamcco/markdown-preview.nvim', build = function() vim.fn["mkdp#util#install"]() end }, -- Markdown preview
	{
		'nvim-telescope/telescope.nvim',
		version = '0.1.1',
		dependencies = {
			{'nvim-lua/plenary.nvim'},
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
			},
			{ "debugloop/telescope-undo.nvim" },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					undo = {
						-- telescope-undo.nvim config, see below
					},
				},
			})
			require("telescope").load_extension("undo")
		end,

	},
	{ 'xiyaowong/transparent.nvim' },
	{
		'olimorris/onedarkpro.nvim',
		priority = 1000 -- Ensure it loads first
	},
	{
		'nvim-telescope/telescope-file-browser.nvim',
		dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim', 'ahmedkhalf/project.nvim' },
	},
	{
		'ahmedkhalf/project.nvim',
	},
	{
		'williamboman/mason.nvim',
		build = ":MasonUpdate" -- :MasonUpdate updates registry contents
	},
	{
		'numToStr/Comment.nvim',
		config = function()
			require("Comment").setup()
		end,
	},
	{ 'nvim-tree/nvim-tree.lua' },
	{'akinsho/toggleterm.nvim', version = "*", config = true},
	{ 'lewis6991/gitsigns.nvim' },
	{ 'neovim/nvim-lspconfig' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-cmdline' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'L3MON4D3/LuaSnip' },
	{ 'saadparwaiz1/cmp_luasnip' },
}
