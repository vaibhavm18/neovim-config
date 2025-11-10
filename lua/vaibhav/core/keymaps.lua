vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set({ "n", "i", "v", "c" }, "<C-[>", "<Esc>", { desc = "Ctrl+[ as Esc" })
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
keymap.set("n", "<leader>ww", ":w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>we", ":Ex<CR>", { desc = "Open file explorer" })
keymap.set("n", "<leader>ws", ":so<CR>", { desc = "Source current file" })
keymap.set("n", "<leader>wc", ":nohl<CR>", { desc = "Clear search highlight" })

keymap.set("n", "<leader>y", '"+y', { desc = "Yank to system clipboard (use with motion)" })
keymap.set("v", "<leader>y", '"+y', { desc = "Yank visual selection to system clipboard" })
keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank current line to system clipboard" })

keymap.set("n", "<leader>d", '"_d', { desc = "Delete to black-hole register (no yank)" })
keymap.set("n", "<leader>D", '"_D', { desc = "Delete end of the line from cursor." })
keymap.set("v", "<leader>d", '"_d', { desc = "Delete visual selection to black-hole" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down and re-indent" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up and re-indent" })

keymap.set("n", "J", "mzJ`z", { desc = "Join next line but restore cursor position" })
keymap.set("x", "<leader>pp", '"_dP', { desc = "Paste over selection without overwriting register" })

keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half-page down and center cursor" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half-page up and center cursor" })

keymap.set("n", "n", "nzzzv", { desc = "Go to next search match, center and open folds" })
keymap.set("n", "N", "Nzzzv", { desc = "Go to previous search match, center and open folds" })
