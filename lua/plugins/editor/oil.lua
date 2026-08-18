return {
  "stevearc/oil.nvim",
  -- Load at startup so oil can act as the default file explorer (nvim .)
  lazy = false,

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  keys = {
    { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
  },

  opts = {
    default_file_explorer = true,
  },
}
