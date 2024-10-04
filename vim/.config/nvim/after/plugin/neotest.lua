local neotest = require("neotest")

neotest.setup({
	lazy = false,
	adapters = {
		require("neotest-plenary"),
		require("neotest-elixir")({
			mix_task = { "test" },
			-- args = { "--stale" },
		}),
	},
})

vim.keymap.set("n", "<leader>tr", function()
	neotest.run.run()
end, { desc = "Neotest run nearest test" })

vim.keymap.set("n", "<leader>tf", function()
	neotest.run.run(vim.fn.expand("%"))
end, { desc = "Neotest run current file" })

vim.keymap.set("n", "<leader>tw", function()
	-- neotest.watch.toggle(vim.fn.expand("%"))
	neotest.watch.watch()
end, { desc = "Toggle neotest watch" })

vim.keymap.set("n", "<leader>ta", function()
	neotest.run.attach()
end, { desc = "Neotest attach" })

vim.keymap.set("n", "<leader>ts", function()
	neotest.summary.toggle()
end, { desc = "Neotest summary" })
