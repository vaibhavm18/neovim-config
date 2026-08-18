return {
	{ "nvim-mini/mini.comment", version = "*", opts = {} },
	{ "nvim-mini/mini.move", version = "*", opts = {} },
	{ "nvim-mini/mini.pairs", version = "*", opts = {} },
	{ "nvim-mini/mini.surround", version = "*", opts = {} },
	{ "nvim-mini/mini.trailspace", version = "*", opts = {} },
  {
        "echasnovski/mini.notify",
        config = function()
            require("mini.notify").setup({
                content = {
                    format = function(notif)
                        return notif.msg
                    end,
                },
                window = {
                    config = function()
                        return {
                            title = "",
                            anchor = "SE",
                            row = vim.o.lines - 2,
                            col = vim.o.columns,
                            border = "none",
                        }
                    end,
                },
            })
        end
    },
}
