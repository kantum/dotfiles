local lsp = require('lsp-zero')
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
	lsp.buffer_autoformat()
end)

require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {},
	handlers = {
		lsp.default_setup,
	},
	require 'lspconfig'.volar.setup {
		on_init = function(client)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentFormattingRangeProvider = false
		end,
	}
})

-- Instead of lsp.buffer_autoformat()
-- lsp.format_on_save({
--   format_opts = {
--     async = false,
--     timeout_ms = 10000,
--   },
--   servers = {
--     ['lua_ls'] = {'lua'},
--     ['rust_analyzer'] = {'rust'},
--     -- if you have a working setup with null-ls
--     -- you can specify filetypes it can format.
--     -- ['null-ls'] = {'javascript', 'typescript'},
--   }
-- })

lsp.setup()
