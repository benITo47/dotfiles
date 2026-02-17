return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	version = "1.*",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},

	opts = function(_, opts)
		opts.sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		}

		opts.keymap = {
			preset = "none",

			-- Navigation (Tab/Shift-Tab as primary, C-j/C-k as alternatives)
			-- Tab: jump snippet fields first, then navigate menu, then fallback
			["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },

			-- Documentation scrolling
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },

			-- Completion control
			["<C-Space>"] = { "show", "show_documentation", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		}

		opts.appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		}

		opts.completion = {
			menu = {
				auto_show = true,
				border = "rounded",
				winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
				scrollbar = true,
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				treesitter_highlighting = true,
				window = {
					border = "rounded",
					min_width = 10,
					max_width = 80,
					max_height = 30,
					scrollbar = true,
				},
			},
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
		}

		opts.fuzzy = {
			implementation = "prefer_rust_with_warning",
		}

		return opts
	end,

	opts_extend = { "sources.default" },

	config = function(_, opts)
		-- Ensure sources.compat is removed
		if opts.sources and opts.sources.compat then
			opts.sources.compat = nil
		end

		require("blink.cmp").setup(opts)

		-- Note: Color/style configurations are handled by the xcodedark theme
		-- They will be automatically applied when the xcodedark theme is loaded
	end,
}
