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

opt.splitright = true
opt.splitbelow = true
opt.undofile = true
