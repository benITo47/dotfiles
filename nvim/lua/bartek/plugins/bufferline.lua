return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				numbers = "none",
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "left",
						separator = true,
					},
				},
				show_buffer_close_icons = false,
				show_close_icon = false,
				separator_style = "thick", -- Clean thick separators
				always_show_bufferline = true,
				enforce_regular_tabs = true,
			},
			highlights = {
				-- Transparent backgrounds for all states
				fill = { bg = "NONE" },
				background = { bg = "NONE" },
				buffer_visible = { bg = "NONE" },
				buffer_selected = {
					bg = "NONE",
					bold = true,
					italic = false,
				},
				separator = { bg = "NONE" },
				separator_visible = { bg = "NONE" },
				separator_selected = { bg = "NONE" },
				indicator_selected = { bg = "NONE" },
				-- Let colorscheme handle foreground colors
			},
		})
	end,
}
