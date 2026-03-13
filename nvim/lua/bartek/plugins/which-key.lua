return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	config = function()
		local wk = require("which-key")

		wk.setup({
			preset = "modern",
			win = {
				border = "rounded",
				padding = { 1, 2 },
			},
			layout = {
				width = { min = 20, max = 50 },
				spacing = 3,
			},
		})
	end,
}
