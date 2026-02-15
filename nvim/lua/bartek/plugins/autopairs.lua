return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			check_ts = true,
			-- nvim-autopairs works independently
			-- blink.cmp's auto_brackets handles completion-specific pairing
		})
	end,
}
