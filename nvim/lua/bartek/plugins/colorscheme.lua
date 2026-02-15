-- ============================================
-- Colorscheme Collection
-- ============================================
-- Multiple themes configured for different contexts
-- Use theme manager (lua/bartek/core/theme-manager.lua) to switch

return {
	-- ============================================
	-- TokyoNight - Main theme (React/JS/TS/Web)
	-- ============================================
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		lazy = true, -- Let theme-manager handle loading
		config = function()
			local transparent = true

			local bg = "#011628"
			local bg_dark = "#011423"
			local bg_highlight = "#143652"
			local bg_search = "#0A64AC"
			local bg_visual = "#275378"
			local fg = "#CBE0F0"
			local fg_dark = "#B4D0E9"
			local fg_gutter = "#627E97"
			local border = "#547998"

			require("tokyonight").setup({
				style = "night",
				transparent = transparent,
				styles = {
					sidebars = transparent and "transparent" or "dark",
					floats = transparent and "transparent" or "dark",
				},
				on_colors = function(colors)
					colors.bg = bg
					colors.bg_dark = transparent and colors.none or bg_dark
					colors.bg_float = transparent and colors.none or bg_dark
					colors.bg_highlight = bg_highlight
					colors.bg_popup = bg_dark
					colors.bg_search = bg_search
					colors.bg_sidebar = transparent and colors.none or bg_dark
					colors.bg_statusline = transparent and colors.none or bg_dark
					colors.bg_visual = bg_visual
					colors.border = border
					colors.fg = fg
					colors.fg_dark = fg_dark
					colors.fg_float = fg
					colors.fg_gutter = fg_gutter
					colors.fg_sidebar = fg_dark
				end,
				on_highlights = function(hl, c)
					-- blink.cmp completion menu highlights
					hl.BlinkCmpMenu = { bg = transparent and c.none or bg_dark, fg = fg }
					hl.BlinkCmpMenuBorder = { bg = transparent and c.none or bg_dark, fg = border }
					hl.BlinkCmpMenuSelection = { bg = bg_visual, fg = fg, bold = true }
					hl.BlinkCmpDoc = { bg = transparent and c.none or bg_dark, fg = fg }
					hl.BlinkCmpDocBorder = { bg = transparent and c.none or bg_dark, fg = border }
				end,
			})
		end,
	},

	-- ============================================
	-- VS Code Dark+ - For C/C++/Systems Programming
	-- ============================================
	{
		"Mofiqul/vscode.nvim",
		priority = 1000,
		lazy = true,
		config = function()
			local c = require("vscode.colors").get_colors()
			require("vscode").setup({
				transparent = true,
				italic_comments = true,
				disable_nvimtree_bg = true,
				color_overrides = {
					vscBack = "NONE",
				},
				group_overrides = {
					-- Make background transparent
					Normal = { bg = "NONE" },
					NormalFloat = { bg = "NONE" },
					SignColumn = { bg = "NONE" },
				},
			})
		end,
	},

	-- ============================================
	-- Nightfox - Alternative dark theme
	-- ============================================
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		lazy = true,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true,
					colorblind = {
						enable = true,
						severity = {
							protan = 0.3,
							deutan = 0.6,
						},
					},
				},
			})
		end,
	},

	-- ============================================
	-- Catppuccin - Pastel theme option
	-- ============================================
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = true,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				transparent_background = true,
				integrations = {
					blink_cmp = true,
					gitsigns = true,
					treesitter = true,
					telescope = true,
					mason = true,
					which_key = true,
					native_lsp = {
						enabled = true,
					},
				},
			})
		end,
	},

	-- ============================================
	-- Rosé Pine - Elegant theme for writing/markdown
	-- ============================================
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		lazy = true,
		config = function()
			require("rose-pine").setup({
				variant = "main", -- auto, main, moon, or dawn
				dark_variant = "main",
				disable_background = true,
				disable_float_background = true,
				disable_italics = false,
			})
		end,
	},

	-- ============================================
	-- Gruvbox - Classic theme
	-- ============================================
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		lazy = true,
		config = function()
			require("gruvbox").setup({
				transparent_mode = true,
				italic = {
					strings = false,
					comments = true,
					operators = false,
					folds = true,
				},
			})
		end,
	},

	-- ============================================
	-- Dracula - Popular dark theme
	-- ============================================
	{
		"Mofiqul/dracula.nvim",
		priority = 1000,
		lazy = true,
		config = function()
			require("dracula").setup({
				transparent_bg = true,
				italic_comment = true,
			})
		end,
	},

	-- ============================================
	-- Nord - Arctic, north-bluish theme
	-- ============================================
	{
		"shaunsingh/nord.nvim",
		priority = 1000,
		lazy = true,
		config = function()
			vim.g.nord_disable_background = true
			vim.g.nord_italic = false
		end,
	},

	-- ============================================
	-- Kanagawa - Japanese aesthetic
	-- ============================================
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		lazy = true,
		config = function()
			require("kanagawa").setup({
				transparent = true,
				theme = "wave", -- dragon, wave, lotus
			})
		end,
	},

	-- ============================================
	-- Everforest - Comfortable green theme
	-- ============================================
	{
		"sainnhe/everforest",
		priority = 1000,
		lazy = true,
		config = function()
			vim.g.everforest_background = "hard"
			vim.g.everforest_transparent_background = 1
			vim.g.everforest_better_performance = 1
		end,
	},

	-- ============================================
	-- OneDark - Atom's iconic theme
	-- ============================================
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		lazy = true,
		config = function()
			require("onedark").setup({
				style = "dark", -- dark, darker, cool, deep, warm, warmer
				transparent = true,
			})
		end,
	},

	-- ============================================
	-- Monokai Pro - Professional theme
	-- ============================================
	{
		"loctvl842/monokai-pro.nvim",
		priority = 1000,
		lazy = true,
		config = function()
			require("monokai-pro").setup({
				transparent_background = true,
				filter = "pro", -- pro, octagon, machine, ristretto, spectrum
			})
		end,
	},
	-- ============================================
	-- GitHub - Light and dark GitHub themes
	-- ============================================
	{
		"projekt0n/github-nvim-theme",
		priority = 1000,
		lazy = true,
		config = function()
			require("github-theme").setup({
				options = {
					transparent = false, -- Light themes need solid backgrounds
					darken = {
						floats = false,
					},
				},
			})
		end,
	},

	-- ============================================
	-- Xcode - Apple's Xcode color schemes
	-- ============================================
	{
		"fraeso/xcodedark.nvim",
		priority = 1000,
		lazy = true,
		config = function()
			require("xcodedark").setup({
				transparent = true,
				integrations = {
					blink = true,
					telescope = true,
					gitsigns = true,
					bufferline = true,
					which_key = true,
					notify = true,
					snacks = true,
				},
				terminal_colors = true,
			})
		end,
	},
}
