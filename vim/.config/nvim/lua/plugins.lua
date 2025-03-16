return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
		config = true,
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
	{ "tpope/vim-abolish" }, -- Abbreviation, Substitution, Coercion
	{ "nvim-tree/nvim-web-devicons" }, -- Statusline icons
	{ "mbbill/undotree" }, -- Undo tree
	-- { "aspeddro/gitui.nvim" },
	-- { "github/copilot.vim" },       -- Copilot
	{
		"zbirenbaum/copilot.lua",
		build = ":Copilot",
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
		version = "0.1.5",
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
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
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
	-- LSP Support
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
	},

	{ "folke/which-key.nvim", dependencies = { "echasnovski/mini.nvim", version = "*" } },
	{ "folke/neodev.nvim" },
	{ "zaldih/themery.nvim" },
	{ "LnL7/vim-nix" },
	{ "sindrets/diffview.nvim" },
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
	{ "stevearc/oil.nvim" },
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	-- { "kdheepak/lazygit.nvim" },
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{ "google/vim-jsonnet" },
	{
		"elixir-tools/elixir-tools.nvim",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local elixir = require("elixir")
			local elixirls = require("elixir.elixirls")

			elixir.setup({
				nextls = { enable = false },
				credo = { enable = false },
				elixirls = {
					enable = true,
					settings = elixirls.settings({
						dialyzerEnabled = false,
						enableTestLenses = false,
					}),
					on_attach = function(client, bufnr)
						vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
						vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
						vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
					end,
				},
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			-- vim.g.vimtex_view_method = "zathura"
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	{ "IndianBoy42/tree-sitter-just" },
	{
		"NoahTheDuke/vim-just",
		ft = { "just" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-neotest/neotest-plenary",
			"antoinemadec/FixCursorHold.nvim",
			"jfpedroza/neotest-elixir",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			disable_mouse = false,
		},
	},
	{ "petertriho/nvim-scrollbar" },
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = {
			-- add any opts here
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			-- {
			-- 	-- Make sure to set this up properly if you have lazy=true
			-- 	"MeanderingProgrammer/render-markdown.nvim",
			-- 	opts = {
			-- 		file_types = { "markdown", "Avante" },
			-- 	},
			-- 	ft = { "markdown", "Avante" },
			-- },
		},
	},

	{
		"kylechui/nvim-surround",
		version = "v2.3.0",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{ "brenoprata10/nvim-highlight-colors" },
}
