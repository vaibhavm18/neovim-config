local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true

-- UI
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.cmdheight = 2

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- Undo / backup / swap
local undodir = vim.fn.expand("~/.local/state/nvim/undo")
vim.fn.mkdir(undodir, "p")
opt.undodir = undodir
opt.undofile = true
opt.backup = false
opt.swapfile = false

opt.scrolloff = 8

-- netrw
vim.cmd("let g:netrw_liststyle = 3")

-- Diagnostics
vim.diagnostic.config({
	update_in_insert = true,
})

-- Inlay hints
if vim.lsp.inlay_hint then
	vim.lsp.inlay_hint.enable(true)
end
