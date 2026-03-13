return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				-- markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "ruff_format", "ruff_organize_imports" },
				cpp = { "clang-format" },
				sh = { "beautysh" },
				bash = { "beautysh" },
				rust = { "rustfmt" },
				swift = { "swiftformat" },
				zsh = { "beautysh" },
				sql = { "sql-formatter" },
			},
			format_on_save = function(bufnr)
				-- Check if format on save is enabled
				local toggles = require("bartek.core.toggles")
				if not toggles.state.format_on_save then
					return
				end

				return {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				}
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
