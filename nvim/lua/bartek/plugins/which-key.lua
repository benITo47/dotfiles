return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.timeoutlen = 500
		vim.api.nvim_set_hl(0, "WhichKey", { bg = "none" })
		vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "WhichKeyBorder", { bg = "none" })
		vim.api.nvim_set_hl(0, "WhichKeyValue", { bg = "none" })

		vim.api.nvim_set_hl(0, "WhichKeyGroup", { bg = "none" })
		vim.api.nvim_set_hl(0, "WhichKeyDesc", { bg = "none" })
	end,
	opts = {},
}
