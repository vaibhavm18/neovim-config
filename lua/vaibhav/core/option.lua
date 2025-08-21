local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.undodir  = undodir
opt.undofile = true


opt.scrolloff = 8;
opt.incsearch = true

opt.undofile = true
opt.backup = false
opt.swapfile = false

opt.incsearch = true
opt.termguicolors = true

vim.cmd("let g:netrw_liststyle = 3")
vim.diagnostic.config({
  update_in_insert = true,
})

if vim.lsp.inlay_hint then
  vim.lsp.inlay_hint.enable(true, { 0 })
end

local undodir = vim.fn.expand("~/.local/state/nvim/undo")
vim.fn.mkdir(undodir, "p")

