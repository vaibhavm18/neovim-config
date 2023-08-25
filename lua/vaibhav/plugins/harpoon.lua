return {
	"theprimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		--
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		local keymap = vim.keymap

		keymap.set("n", "<leader>a", mark.add_file, {})
		keymap.set("n", "<C-n>", ui.toggle_quick_menu, {})
	end,
}
