return {
  "stevearc/conform.nvim",

  event = { "BufReadPre", "BufNewFile" },

  keys = {
    {
      "<leader>mp",
      function()
        require("conform").format({ lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format file or range",
    },
  },

  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "gofumpt", "goimports" },
    },

    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
