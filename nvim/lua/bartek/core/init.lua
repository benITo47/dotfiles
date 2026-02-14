require("bartek.core.options")
require("bartek.core.keymaps")

-- Theme Manager - Load after plugins
vim.schedule(function()
	require("bartek.core.theme-manager").setup()
end)
