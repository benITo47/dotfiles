-- ============================================
-- Harpoon - Quick File Navigation
-- ============================================
-- Toggleable: Set enabled = true to use it
-- Quick mark and jump between your most used files

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	enabled = true, -- Set to true to enable Harpoon
	config = function()
		local harpoon = require("harpoon")

		-- Helper to show only filename + 2 dirs above
		local function shorten_path(path)
			local parts = vim.split(path, "/")
			local len = #parts
			if len <= 3 then
				return path
			end
			-- Show last 3 parts: dir1/dir2/file.ext
			return table.concat({ parts[len - 2], parts[len - 1], parts[len] }, "/")
		end

		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
				key = function()
					return vim.loop.cwd()
				end,
			},
			menu = {
				width = 60,
				height = 10,
			},
			-- Custom display
			default = {
				display = function(item)
					return shorten_path(item.value)
				end,
			},
		})

		-- Keybindings
		local map = vim.keymap.set

		-- Add/Remove files
		map("n", "<leader>ha", function()
			harpoon:list():add()
			vim.notify("File added to Harpoon", vim.log.levels.INFO)
		end, { desc = "Harpoon: Add file" })

		map("n", "<leader>hr", function()
			harpoon:list():remove()
			vim.notify("File removed from Harpoon", vim.log.levels.INFO)
		end, { desc = "Harpoon: Remove file" })

		-- Toggle menu
		map("n", "<leader>hh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon: Toggle menu" })

		-- Jump to marked files (1-4)
		map("n", "<C-1>", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon: Jump to file 1" })

		map("n", "<C-2>", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon: Jump to file 2" })

		map("n", "<C-3>", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon: Jump to file 3" })

		map("n", "<C-4>", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon: Jump to file 4" })

		-- Navigate through list
		map("n", "<C-S-P>", function()
			harpoon:list():prev()
		end, { desc = "Harpoon: Previous file" })

		map("n", "<C-S-N>", function()
			harpoon:list():next()
		end, { desc = "Harpoon: Next file" })
	end,
}
