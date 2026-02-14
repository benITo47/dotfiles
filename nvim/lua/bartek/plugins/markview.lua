return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	ft = { "markdown", "latex", "typst", "html", "yaml" },
	keys = {
		{
			"<leader>mv",
			":Markview Toggle<CR>",
			desc = "Toggle Markview (Enable/Disable)",
		},
		{
			"<leader>ms",
			":Markview splitToggle<CR>",
			desc = "Toggle Markview Split View",
		},
		{
			"<leader>mh",
			":Markview HybridToggle<CR>",
			desc = "Toggle Markview Hybrid Mode",
		},
	},

	opts = function()
		local presets = require("markview.presets")

		return {
			preview = {
				hybrid_modes = { "n", "v" },
				enable_hybrid_mode = false,

				icon_provider = "devicons",
			},

			markdown = {
				headings = presets.headings.glow,
				tables = presets.tables.double,
			},
		}
	end,
}
