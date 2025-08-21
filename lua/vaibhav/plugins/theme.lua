return {
  {
    { "EdenEast/nightfox.nvim" },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},

  },
  {
    {'shaunsingh/nord.nvim'}
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000,
  config = function ()
    vim.cmd.colorscheme "catppuccin-mocha" 
  end
},
{
  "rebelot/kanagawa.nvim",
  name = "kanagawa",
  priority = 1000,
  config = function ()
    -- vim.cmd.colorscheme "kanagawa-wave" 
  end
  },
  { "savq/melange-nvim",
    priority = 1000,
    config = function ()
      -- vim.cmd.colorscheme "melange" 
    end
  }
}
