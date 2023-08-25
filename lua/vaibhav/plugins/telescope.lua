return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local keymap = vim.keymap
		local builtin = require("telescope.builtin")

		keymap.set("n", "<leader>pf", builtin.find_files, {})
		keymap.set("n", "<C-p>", builtin.git_files, {})

		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, {})
	end,
}
