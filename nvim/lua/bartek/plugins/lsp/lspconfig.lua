return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},

	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local map = vim.keymap.set

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- LSP Navigation
				opts.desc = "Goto Definition"
				map("n", "gd", vim.lsp.buf.definition, opts)

				opts.desc = "Goto Declaration"
				map("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show References"
				map("n", "gr", vim.lsp.buf.references, opts)

				opts.desc = "Goto Implementation"
				map("n", "gI", vim.lsp.buf.implementation, opts)

				opts.desc = "Goto Type Definition"
				map("n", "gy", vim.lsp.buf.type_definition, opts)

				-- LSP Actions
				opts.desc = "Smart rename"
				map("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Code Actions"
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Show buffer diagnostics"
				map("n", "<leader>dD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				map("n", "<leader>dd", vim.diagnostic.open_float, opts)

				opts.desc = "Show documentation for what is under cursor"
				map("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				map("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Style hover to match blink.cmp documentation window
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
			max_width = 80,
			max_height = 30,
			winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder",
		})

		-- Standalone sourcekit setup with merged capabilities

	-- Configure all LSP servers
	-- Lua
	vim.lsp.config("lua_ls", {
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				completion = { callSnippet = "Replace" },
			},
		},
	})
	vim.lsp.enable("lua_ls")

	-- TypeScript/JavaScript
	vim.lsp.config("ts_ls", {
		capabilities = capabilities,
		filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		on_attach = function(client)
			client.server_capabilities.documentFormattingProvider = false
		end,
	})
	vim.lsp.enable("ts_ls")

	-- ESLint
	vim.lsp.config("eslint", {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				command = "EslintFixAll",
			})
		end,
		filetypes = { "javascript", "javascriptreact" },
	})
	vim.lsp.enable("eslint")

	-- HTML
	vim.lsp.config("html", {
		capabilities = capabilities,
		filetypes = { "html", "htmldjango" },
	})
	vim.lsp.enable("html")

	-- CSS
	vim.lsp.config("cssls", {
		capabilities = capabilities,
		filetypes = { "css", "scss", "sass", "less" },
	})
	vim.lsp.enable("cssls")

	-- Python
	vim.lsp.config("pyright", {
		capabilities = capabilities,
		filetypes = { "python" },
	})
	vim.lsp.enable("pyright")

	-- Rust
	vim.lsp.config("rust_analyzer", {
		capabilities = capabilities,
		filetypes = { "rust" },
	})
	vim.lsp.enable("rust_analyzer")

	-- Bash
	vim.lsp.config("bashls", {
		capabilities = capabilities,
		filetypes = { "sh", "bash", "zsh" },
	})
	vim.lsp.enable("bashls")

	-- Docker
	vim.lsp.config("dockerls", {
		capabilities = capabilities,
		filetypes = { "Dockerfile", "dockerfile" },
	})
	vim.lsp.enable("dockerls")

	-- LTeX (Markdown/LaTeX)
	vim.lsp.config("ltex", {
		capabilities = capabilities,
		settings = { ltex = { language = "en-EN" } },
		filetypes = { "markdown", "tex", "plaintex" },
	})
	vim.lsp.enable("ltex")

	-- Clangd (C/C++)
	vim.lsp.config("clangd", {
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--completion-style=detailed",
			"--header-insertion=iwyu",
			"--header-insertion-decorators",
			"--pch-storage=memory",
		},
		capabilities = vim.tbl_deep_extend("force", capabilities, {
			offsetEncoding = { "utf-16" },
		}),
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		root_dir = function(fname)
			return require("lspconfig.util").root_pattern(
				".clangd",
				".clang-tidy",
				".clang-format",
				"compile_commands.json",
				"compile_flags.txt",
				"configure.ac",
				".git"
			)(fname) or vim.fn.getcwd()
		end,
		init_options = {
			fallbackFlags = { "-std=c++20" },
		},
	})
	vim.lsp.enable("clangd")

		local sourcekit_capabilities = vim.tbl_deep_extend(
			"force",
			capabilities,
			{
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			}
		)

		vim.lsp.config("sourcekit", {
			capabilities = sourcekit_capabilities,
		})
		vim.lsp.enable("sourcekit")
	end,
}
