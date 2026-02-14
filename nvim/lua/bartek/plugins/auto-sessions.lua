return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")
		auto_session.setup({
			auto_restore = false, -- Updated from auto_restore_enabled
			suppressed_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop" },
		})

		local map = vim.keymap.set

		map("n", "<leader>wr", "<cmd>AutoSession search<CR>", { desc = "Search and restore session" })
		map("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session" })
		map("n", "<leader>wd", "<cmd>AutoSession delete<CR>", { desc = "Delete session" })
	end,
}
