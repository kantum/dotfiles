require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		javascript,
		typescript = { "prettierd", "prettier", stop_after_first = true },
		elixir = { "mix" },
		heex = { "mix" },
		vue = { "prettierd" },
		nix = { "alejandra" },
	},
})
