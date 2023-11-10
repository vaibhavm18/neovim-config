local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.clipboard = "unnamedplus"

opt.tabstop = 2
opt.shiftwidth = 2

opt.smartindent = true
opt.scrolloff = 8

-- opt.guicursor = ""

opt.relativenumber = true

vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
