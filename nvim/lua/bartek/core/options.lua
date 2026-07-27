vim.cmd("let g:netrw_liststyle=3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

--tabs
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true -- expands tab to spaces
opt.autoindent = true -- keeps indenation
opt.smartindent = true -- Smarter auto-indentation
opt.breakindent = true -- Preserve indent on wrapped lines

opt.ignorecase = true -- for searching
opt.smartcase = true -- if mixed Case, then search case sensitive

opt.cursorline = true
opt.whichwrap:append("<", "h")
opt.whichwrap:append(">", "l")

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

-- Over ssh there is no local clipboard tool worth using (xclip without DISPLAY just
-- fails silently), so push yanks to the *local* terminal with OSC52.
if vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
	local osc52 = require("vim.ui.clipboard.osc52")
	vim.g.clipboard = {
		name = "OSC 52",
		copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
		-- OSC52 reads hang on most terminals; paste from the unnamed register instead
		paste = { ["+"] = function() return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") } end },
	}
	vim.g.clipboard.paste["*"] = vim.g.clipboard.paste["+"]
end

opt.splitright = true
opt.splitbelow = true
opt.undofile = true

vim.o.winborder = "rounded" -- default rounded border for all floating windows (hover, diagnostics, etc.)
