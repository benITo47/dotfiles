-- ============================================
-- Theme Manager - Simple & Reliable
-- ============================================

local M = {}

-- Available themes
M.themes = {
	{ name = "tokyonight", desc = "TokyoNight - Modern Dark", ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" } },
	{ name = "vscode", desc = "VS Code Dark+ - Familiar", ft = { "c", "cpp", "objc", "objcpp" } },
	{ name = "catppuccin", desc = "Catppuccin - Pastel", ft = { "python", "go", "rust" } },
	{ name = "rose-pine", desc = "Rosé Pine - Elegant", ft = { "markdown", "text" } },
	{ name = "dracula", desc = "Dracula - Popular Dark", ft = {} },
	{ name = "nord", desc = "Nord - Arctic Blue", ft = {} },
	{ name = "kanagawa", desc = "Kanagawa - Japanese Zen", ft = {} },
	{ name = "everforest", desc = "Everforest - Comfortable Green", ft = {} },
	{ name = "onedark", desc = "OneDark - Atom Classic", ft = {} },
	{ name = "monokai-pro", desc = "Monokai Pro - Professional", ft = {} },
	{ name = "github_dark", desc = "GitHub Dark", ft = {} },
	{ name = "github_light", desc = "GitHub Light", ft = {} },
	{ name = "nightfox", desc = "Nightfox - Dark Fox", ft = {} },
	{ name = "gruvbox", desc = "Gruvbox - Retro Groove", ft = {} },
}

M.default_theme = "tokyonight"
M.current_theme = nil
M.auto_switch = true  -- Enable auto-switch
M.switching = false
M.last_ft = nil  -- Track last filetype to prevent redundant switches

-- Persistence
M.data_file = vim.fn.stdpath("data") .. "/theme.txt"

function M.save_theme()
	local file = io.open(M.data_file, "w")
	if file then
		file:write(M.current_theme or M.default_theme)
		file:close()
	end
end

function M.load_theme()
	local file = io.open(M.data_file, "r")
	if file then
		local theme = file:read("*a"):gsub("%s+", "")
		file:close()
		if theme and theme ~= "" then
			M.default_theme = theme
		end
	end
end

function M.apply_theme(theme_name, silent)
	if M.switching or M.current_theme == theme_name then
		return
	end

	M.switching = true

	local ok = pcall(vim.cmd.colorscheme, theme_name)
	if ok then
		M.current_theme = theme_name
		M.save_theme()
		if not silent then
			vim.notify("Theme: " .. theme_name, vim.log.levels.INFO)
		end
	else
		if not silent then
			vim.notify("Failed to load: " .. theme_name, vim.log.levels.ERROR)
		end
	end

	M.switching = false
end

function M.pick_theme()
	local original_theme = M.current_theme or M.default_theme
	local selected_idx = 1

	-- Find current theme index
	for i, theme in ipairs(M.themes) do
		if theme.name == M.current_theme then
			selected_idx = i
			break
		end
	end

	-- Create buffer and window
	local buf = vim.api.nvim_create_buf(false, true)
	local width = 60
	local height = #M.themes + 2
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " Select Theme (j/k to preview, Enter to confirm) ",
		title_pos = "center",
	})

	-- Render items
	local function render()
		local lines = {}
		for i, theme in ipairs(M.themes) do
			local marker = (i == selected_idx) and "󰄬 " or "  "
			lines[i] = marker .. theme.desc
		end
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
		vim.api.nvim_win_set_cursor(win, { selected_idx, 0 })
	end

	-- Apply preview theme
	local function preview()
		M.apply_theme(M.themes[selected_idx].name, true)
	end

	-- Initial render and preview
	render()
	preview()

	-- Keymaps
	local opts = { buffer = buf, nowait = true }

	vim.keymap.set("n", "j", function()
		selected_idx = selected_idx < #M.themes and selected_idx + 1 or 1
		render()
		preview()
	end, opts)

	vim.keymap.set("n", "k", function()
		selected_idx = selected_idx > 1 and selected_idx - 1 or #M.themes
		render()
		preview()
	end, opts)

	vim.keymap.set("n", "<Down>", function()
		selected_idx = selected_idx < #M.themes and selected_idx + 1 or 1
		render()
		preview()
	end, opts)

	vim.keymap.set("n", "<Up>", function()
		selected_idx = selected_idx > 1 and selected_idx - 1 or #M.themes
		render()
		preview()
	end, opts)

	vim.keymap.set("n", "<CR>", function()
		M.apply_theme(M.themes[selected_idx].name, false)
		vim.api.nvim_win_close(win, true)
	end, opts)

	vim.keymap.set("n", "<Esc>", function()
		M.apply_theme(original_theme, true)
		vim.api.nvim_win_close(win, true)
	end, opts)

	vim.keymap.set("n", "q", function()
		M.apply_theme(original_theme, true)
		vim.api.nvim_win_close(win, true)
	end, opts)
end

function M.next_theme()
	local current_idx = 1
	for i, theme in ipairs(M.themes) do
		if theme.name == M.current_theme then
			current_idx = i
			break
		end
	end

	local next_idx = (current_idx % #M.themes) + 1
	M.apply_theme(M.themes[next_idx].name)
end

function M.prev_theme()
	local current_idx = 1
	for i, theme in ipairs(M.themes) do
		if theme.name == M.current_theme then
			current_idx = i
			break
		end
	end

	local prev_idx = current_idx - 1
	if prev_idx < 1 then
		prev_idx = #M.themes
	end
	M.apply_theme(M.themes[prev_idx].name)
end

function M.auto_switch_theme()
	if not M.auto_switch then
		return
	end

	local ft = vim.bo.filetype
	if ft == "" or ft == M.last_ft then
		return
	end

	M.last_ft = ft

	for _, theme in ipairs(M.themes) do
		for _, filetype in ipairs(theme.ft) do
			if filetype == ft then
				M.apply_theme(theme.name, true)
				return
			end
		end
	end
end

function M.toggle_auto_switch()
	M.auto_switch = not M.auto_switch
	vim.notify("Auto-switch: " .. (M.auto_switch and "ON" or "OFF"))
end

function M.setup()
	-- Load saved theme
	M.load_theme()

	-- Apply immediately
	M.apply_theme(M.default_theme, true)

	-- Auto-switch on FileType and BufEnter (for tab/buffer switching)
	local group = vim.api.nvim_create_augroup("ThemeAutoSwitch", { clear = true })

	vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
		group = group,
		callback = function()
			vim.defer_fn(M.auto_switch_theme, 50)
		end,
	})

	-- Keybindings
	vim.keymap.set("n", "<leader>ut", M.pick_theme, { desc = "Theme picker" })
	vim.keymap.set("n", "<leader>u1", function() M.apply_theme("tokyonight") end, { desc = "TokyoNight" })
	vim.keymap.set("n", "<leader>u2", function() M.apply_theme("vscode") end, { desc = "VS Code" })
	vim.keymap.set("n", "<leader>u3", function() M.apply_theme("rose-pine") end, { desc = "Rosé Pine" })
	vim.keymap.set("n", "<leader>u]", M.next_theme, { desc = "Next theme" })
	vim.keymap.set("n", "<leader>u[", M.prev_theme, { desc = "Prev theme" })
	vim.keymap.set("n", "<leader>ua", M.toggle_auto_switch, { desc = "Toggle auto-switch" })
end

return M
