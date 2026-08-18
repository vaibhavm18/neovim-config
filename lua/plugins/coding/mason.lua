return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",

    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },

    opts = {
      ensure_installed = {
        "lua_ls",
      },

      -- stylua is run as a formatter by conform, don't start its LSP mode
      automatic_enable = {
        exclude = { "stylua" },
      },
    },
  },
}
