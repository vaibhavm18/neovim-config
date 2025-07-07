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

local hi = ""
-- -- ~/.config/nvim/init.lua (or any Lua file that runs on start-up)
-- vim.diagnostic.config({
--   virtual_text = {
--     spacing = 2,        -- columns between code & message
--     prefix  = "●",      -- could be "■", "", "▎", or "" for no prefix
--     severity = {        -- only show from this level up
--       min = vim.diagnostic.severity.HINT,
--     },
--   },
--   signs     = true,     -- keep the gutter icons
--   underline = true,     -- subtle underline under the error range
--   update_in_insert = false,  -- don’t spam while you type (set true if you like)
-- })

