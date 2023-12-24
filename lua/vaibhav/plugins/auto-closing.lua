return {
	"windwp/nvim-ts-autotag",
	ft = {
		"javascript",
		"javascriptreact",
		"typescriptreact",
		"typescript",
	},

	config = function()
		require("nvim-ts-autotag").setup({
			autotag = {
				enable = true,
			},
		})
	end,
}
