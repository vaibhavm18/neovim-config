
vim.g.mapleader = " "


local keymap = vim.keymap


keymap.set("n", "<leader>ww", ":w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>wp", ":Ex<CR>", { desc = "Explore" })
keymap.set("n", "<leader>wo", ":so<CR>", { desc = "Source file" })
keymap.set("n", "<leader>wc", ":noh<CR>", { desc = "Clear the search" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z")
keymap.set("x", "<leader>pp", "\"_dP")

keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("n", "<leader>y", "\"+y")
keymap.set("v", "<leader>y", "\"+y")
keymap.set("n", "<leader>Y", "\"+Y")

keymap.set("n", "<leader>d", "\"_d")
keymap.set("v", "<leader>d", "\"_d")

keymap.set("n", "<leader>rr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("n", "<leader>rx", "<cmd>!chmod +x %<CR>", { silent = true })






