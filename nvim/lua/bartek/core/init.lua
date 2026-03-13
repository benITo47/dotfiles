require("bartek.core.options")
require("bartek.core.keymaps")

-- Toggles - Setup after plugins load
vim.schedule(function()
	require("bartek.core.toggles").setup_keymaps()
end)

-- Theme Manager - Load after plugins
vim.schedule(function()
	require("bartek.core.theme-manager").setup()
end)
