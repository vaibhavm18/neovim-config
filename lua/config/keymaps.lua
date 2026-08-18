vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<CR>", {
  desc = "Save file",
})

map("n", "<leader>W", "<cmd>wall<CR>", {
  desc = "Save all files",
})

map("n", "<leader>so", "<cmd>:so<CR>", { desc = "Source", })

-- System clipboard: plain y/p stay inside nvim, <leader> variants hit the OS clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>Y", '"+y$', { desc = "Yank to end of line to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
map({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from system clipboard" })

map({ "n", "i", "v", "c" }, "<C-]>", "<Esc>", { desc = "Ctrl+] as Esc" })

map("n", "<leader>h", ":nohl<CR>", { desc = "Clear search highlight" })

map("n", "<leader>d", '"_d', { desc = "Delete to black-hole register (no yank)" })
map("n", "<leader>D", '"_D', { desc = "Delete end of the line from cursor" })
map("v", "<leader>d", '"_d', { desc = "Delete visual selection to black-hole" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down and re-indent" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up and re-indent" })

map("n", "J", "mzJ`z", { desc = "Join next line but restore cursor position" })
map("x", "<leader>rp", '"_dP', { desc = "Replace selection with paste, keep register" })

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll half-page down and center cursor" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll half-page up and center cursor" })

map("n", "n", "nzzzv", { desc = "Go to next search match, center and open folds" })
map("n", "N", "Nzzzv", { desc = "Go to previous search match, center and open folds" })
