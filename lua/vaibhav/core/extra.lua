vim.cmd("let g:netrw_liststyle = 3")
vim.diagnostic.config({
  update_in_insert = true,
})

if vim.lsp.inlay_hint then
  vim.lsp.inlay_hint.enable(true, { 0 })
end

local undodir = vim.fn.expand("~/.local/state/nvim/undo")
vim.fn.mkdir(undodir, "p")

vim.opt.undodir  = undodir
vim.opt.undofile = true

