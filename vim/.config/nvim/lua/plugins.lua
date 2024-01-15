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
	{ "ap/vim-css-color" }, -- Css colors show in code
	{ "junegunn/goyo.vim" },
	{ "tpope/vim-fugitive" }, -- git plugin
	{ "tpope/vim-rhubarb" }, -- git plugin
	{ "nvim-tree/nvim-web-devicons" }, -- Statusline icons
	{ "mbbill/undotree" }, -- Undo tree
	{ "aspeddro/gitui.nvim" },
	-- { "github/copilot.vim" },       -- Copilot
	{
		"zbirenbaum/copilot.lua",
		build = "Copilot",
	},
	{
		"jonahgoldwastaken/copilot-status.nvim",
		dependencies = { "copilot.lua" }, -- or "zbirenbaum/copilot.lua"
		lazy = true,
		event = "BufReadPost",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- or "zbirenbaum/copilot.lua"
	},
	-- {
	-- 	'codota/tabnine-nvim',
	-- 	build = "./dl_binaries.sh"
	-- },
	{ "rust-lang/rust.vim" }, -- Rust
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
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
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "ahmedkhalf/project.nvim" },
	},
	{ "ahmedkhalf/project.nvim" },
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
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
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
	{ "windwp/nvim-ts-autotag" },

	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
		},
	},

	--- Uncomment these if you want to manage LSP servers from neovim
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	-- LSP Support
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
		},
	},

	{ "folke/which-key.nvim" },
	{ "folke/neodev.nvim" },
	{ "zaldih/themery.nvim" },
	{ "LnL7/vim-nix" },
	{ "sindrets/diffview.nvim" },
	{ "mhartington/formatter.nvim" },
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{ "digitaltoad/vim-pug" },
	{
		"mrcjkb/rustaceanvim",
		version = "^3", -- Recommended
		ft = { "rust" },
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
}
