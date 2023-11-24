vim.g.mapleader = " "

local keymap = vim.keymap

-- General keymaps
keymap.set("n", "<leader>e", "<cmd>:Ex<CR>", {})
keymap.set("n", "<leader>w", "<cmd>:w<CR>", {})

keymap.set("i", "jj", "<Esc>", {})

-- deleting char without copying char
keymap.set("n", "x", '"_x"')
