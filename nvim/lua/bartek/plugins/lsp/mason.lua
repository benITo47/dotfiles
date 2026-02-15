return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")

		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"clangd",
				"cssls",
				"dockerls",
				"html",
				"eslint", --JavaScript only
				"lua_ls",
				"pyright",
				"ltex", --tex + markdown
				"ts_ls", -- ts + react
				"bashls",
				"rust_analyzer",
				-- "sourcekit",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"clang-format",
				"beautysh",
				"sql-formatter",
				"pylint",
				"eslint_d",
				"rustfmt",
			},
		})
	end,
}
