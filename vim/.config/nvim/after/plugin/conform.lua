local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		json = { "prettier" },
		mjs = { "prettier" },
		elixir = { "mix" },
		heex = { "mix" },
		vue = { "prettier" },
		svelte = { "prettier" },
		tsx = { "eslint" },
		nix = { "alejandra" },
		go = { "gofmt", "gofumpt" },
	},
})
