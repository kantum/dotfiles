return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	},
	-- { 'editorconfig/editorconfig-vim' }, -- Editorconfig
	-- { 'tribela/vim-transparent' }, -- Transparent background
	-- { 'nvim-lualine/lualine.nvim' }, -- Statusline
	{ "ap/vim-css-color" }, -- Css colors show in code
	-- { 'neoclide/coc.nvim', branch= 'release'}, -- Coc
	{ "junegunn/goyo.vim" },
	{ "tpope/vim-fugitive" },       -- git plugin
	{ "tpope/vim-rhubarb" },        -- git plugin
	{ "nvim-tree/nvim-web-devicons" }, -- Statusline icons
	{ "mbbill/undotree" },          -- Undo tree
	{ "aspeddro/gitui.nvim" },
	{ "github/copilot.vim" },       -- Copilot
	{ "rust-lang/rust.vim" },       -- Rust
	{ "MunifTanjim/prettier.nvim" }, -- Rust
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	}, -- Rust
	-- { 'fatih/vim-go',                 build = ':GoUpdateBinaries' },                       -- Go
	-- Debug Adapter Protocol for go
	{ "theHamsta/nvim-dap-virtual-text" },
	{ "mfussenegger/nvim-dap" },
	{ "rcarriga/nvim-dap-ui" },
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	}, -- Markdown preview
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.1",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build =
				"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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
	{ "xiyaowong/transparent.nvim" },
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "ahmedkhalf/project.nvim" },
	},
	{
		"ahmedkhalf/project.nvim",
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{ "nvim-tree/nvim-tree.lua" },
	{ "akinsho/toggleterm.nvim",   version = "*", config = true },
	{ "lewis6991/gitsigns.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "simrat39/rust-tools.nvim" },
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	{ "m4xshen/autoclose.nvim" },                         -- autoclose quotes
	{ "windwp/nvim-ts-autotag" },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },    -- Required
			{ "williamboman/mason.nvim" },  -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
		},
	},
}
