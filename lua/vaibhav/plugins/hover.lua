return {
	"lewis6991/hover.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("hover").setup({
			init = function()
				-- Require providers
				require("hover.providers.lsp")
				-- require('hover.providers.gh')
				-- require('hover.providers.gh_user')
				-- require('hover.providers.jira')
				-- require('hover.providers.man')
				-- require('hover.providers.dictionary')
			end,
			preview_opts = {
				border = "single",
			},
			-- Whether the contents of a currently open hover window should be moved
			-- to a :h preview-window when pressing the hover keymap.
			preview_window = false,
			title = true,
			mouse_providers = {
				"LSP",
			},
			mouse_delay = 1000,
		})

		-- Setup keymaps
		vim.keymap.set("n", "<leader>h", require("hover").hover, { desc = "hover.nvim" })
		vim.keymap.set("n", "<leader>hs", require("hover").hover_select, { desc = "hover.nvim (select)" })

		-- Mouse support
		vim.o.mousemoveevent = true
	end,
}
