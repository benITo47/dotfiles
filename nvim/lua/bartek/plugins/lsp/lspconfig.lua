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

				-- Enable inlay hints if supported
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client and client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
				end

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
				map("n", "K", function()
					vim.lsp.buf.hover({ max_width = 150, max_height = 45 })
				end, opts)

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

		-- Neovim 0.11: vim.lsp.handlers overrides no longer work for hover windows.
		-- Match blink.cmp doc highlight groups on any markdown floating window (hover, blink doc).
		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = vim.api.nvim_create_augroup("LspHoverBlinkStyle", { clear = true }),
			callback = function(args)
				for _, win in ipairs(vim.fn.win_findbuf(args.buf)) do
					local cfg = vim.api.nvim_win_get_config(win)
					if cfg.relative ~= "" and vim.bo[args.buf].filetype == "markdown" then
						vim.wo[win].winhighlight =
							"Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDocBorder"
					end
				end
			end,
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
					hint = {
						enable = true,
						setType = true,
						paramName = "All",
						paramType = true,
						arrayIndex = "Disable",
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")

		-- TypeScript/JavaScript
		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			},
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

		-- Python - using basedpyright for better venv support
		vim.lsp.config("basedpyright", {
			capabilities = capabilities,
			filetypes = { "python" },
			settings = {
				basedpyright = {
					analysis = {
						typeCheckingMode = "basic", -- Options: "off", "basic", "standard", "strict"
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "workspace", -- "openFilesOnly" or "workspace"
						autoImportCompletions = true,
						inlayHints = {
							variableTypes = true,
							functionReturnTypes = true,
							callArgumentNames = true,
							pytestParameters = true,
						},
					},
				},
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "workspace",
					},
					-- Virtual environment detection
					venvPath = ".",
					pythonPath = vim.fn.exepath("python3") or vim.fn.exepath("python"),
				},
			},
			before_init = function(_, config)
				-- Auto-detect virtual environment
				local venv = vim.fn.getenv("VIRTUAL_ENV")
				if venv ~= vim.NIL and venv ~= "" then
					config.settings.python.pythonPath = venv .. "/bin/python"
				else
					-- Look for common venv directories
					local venv_paths = { "venv", ".venv", "env", ".env" }
					for _, path in ipairs(venv_paths) do
						local venv_python = vim.fn.getcwd() .. "/" .. path .. "/bin/python"
						if vim.fn.executable(venv_python) == 1 then
							config.settings.python.pythonPath = venv_python
							break
						end
					end
				end
			end,
		})
		vim.lsp.enable("basedpyright")

		-- Rust
		vim.lsp.config("rust_analyzer", {
			capabilities = capabilities,
			filetypes = { "rust" },
			settings = {
				["rust-analyzer"] = {
					inlayHints = {
						bindingModeHints = { enable = false }, -- Don't show & or &mut
						chainingHints = { enable = true }, -- Show types for method chains
						closingBraceHints = { enable = false }, -- Don't show closing brace labels
						closureReturnTypeHints = { enable = "never" }, -- Don't show closure return types
						lifetimeElisionHints = { enable = "never" }, -- Don't show elided lifetimes
						maxLength = 25,
						parameterHints = { enable = false }, -- Don't show parameter names (redundant!)
						reborrowHints = { enable = "never" }, -- Don't show reborrow hints
						renderColons = true,
						typeHints = {
							enable = true, -- Only show inferred variable types
							hideClosureInitialization = true,
							hideNamedConstructor = true,
						},
					},
				},
			},
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
				"--inlay-hints",
			},
			capabilities = vim.tbl_deep_extend("force", capabilities, {
				offsetEncoding = { "utf-16" },
			}),
			filetypes = { "c", "tpp", "cpp", "objc", "objcpp", "cuda", "proto" },
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

		local sourcekit_capabilities = vim.tbl_deep_extend("force", capabilities, {
			workspace = {
				didChangeWatchedFiles = {
					dynamicRegistration = true,
				},
			},
		})

		vim.lsp.config("sourcekit", {
			capabilities = sourcekit_capabilities,
		})
		vim.lsp.enable("sourcekit")
	end,
}
