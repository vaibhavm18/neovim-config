local M = {}

vim.filetype.add({
	extension = {
		toy = "toy",
	},
})
-- Attach everywhere for easy testing (every markdown file)
local function always_root_dir(_, on_dir)
	on_dir(vim.fn.getcwd())
end

function M.setup(capabilities)
	vim.lsp.config("test_lsp", {
		name = "test-lsp", -- shows up as client.name
		cmd = { "/home/vaibhav18/personal/projects/lsp/lsp", "--stdio" }, -- your executable name + args
		filetypes = { "markdown", "toy" },
		root_dir = always_root_dir,
		capabilities = capabilities,
	})

	-- Enable it (0.11+)
	vim.lsp.enable("test_lsp")
end

return M
