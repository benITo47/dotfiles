return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"wojciech-kulik/xcodebuild.nvim",
	},
	config = function()
		local codelldbPath = vim.fn.expand("$MASON/bin/codelldb")

		-- xcodebuild.setup(codelldbPath)
		--
		-- vim.keymap.set("n", "<leader>db", xcodebuild.build_and_debug, { desc = "Build & Debug" })
		-- vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
		-- vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
		-- vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
		-- vim.keymap.set("n", "<leader>bb", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		-- vim.keymap.set("n", "<leader>Bb", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
		-- vim.keymap.set("n", "<leader>dx", xcodebuild.terminate_session, { desc = "Terminate Debugger" })
	end,
}
