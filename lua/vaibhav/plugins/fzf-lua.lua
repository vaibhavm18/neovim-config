return {
	"ibhagwan/fzf-lua",
	-- optional icon support (remove if you don't use an icon provider)
	dependencies = { "nvim-mini/mini.icons" },

	-- plugin options (see fzf-lua docs for full list)
	opts = {
		-- example: customize window and preview behavior
		-- winopts = { height = 0.40, width = 0.90, border = "rounded" },
		-- files = { cmd = "rg --files --hidden --glob '!.git/*'" },
	},

	keys = {
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "Project: find files (fzf-lua file picker)",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Project: live grep (ripgrep)",
		},
		{
			"<leader>fc",
			function()
				require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Neovim: find files in your config directory",
		},
		{
			"<leader>fh",
			function()
				require("fzf-lua").helptags()
			end,
			desc = "Help: search Neovim help tags",
		},
		{
			"<leader>fk",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "Search keymaps: show mapped keys and bindings",
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").builtin()
			end,
			desc = "Builtin: list fzf-lua builtin pickers",
		},
		{
			"<leader>fw",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "Search: grep for the word under cursor (case-sensitive)",
		},
		{
			"<leader>fW",
			function()
				require("fzf-lua").grep_cWORD()
			end,
			desc = "Search: grep for the WORD under cursor (big WORD)",
		},
		{
			"<leader>fd",
			function()
				require("fzf-lua").diagnostics_document()
			end,
			desc = "Diagnostics: search current buffer diagnostics",
		},
		{
			"<leader>fr",
			function()
				require("fzf-lua").resume()
			end,
			desc = "Resume: reopen the last fzf-lua picker",
		},
		{
			"<leader>fo",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "History: open recently used files",
		},
		{
			"<leader><leader>",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Buffers: switch to an open buffer",
		},
		{
			"<leader>/",
			function()
				require("fzf-lua").lgrep_curbuf()
			end,
			desc = "Live grep: search inside the current buffer",
		},
	},
}
