return {
	"nvim-telescope/telescope.nvim",
	-- branch = "0.1.x",
	tag = "0.1.4",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<C-p>", builtin.git_files, { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Fuzzy find recent files" })
		keymap.set("n", "<C-f>", builtin.buffers, { desc = "Find recent filse" })
		keymap.set("n", "<leader>fc", builtin.help_tags, { desc = "Find string under cursor in cwd" })
		--
	end,
}
