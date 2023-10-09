return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		flavour = "mocha", vim.cmd.colorscheme("catppuccin")
	end,
}
