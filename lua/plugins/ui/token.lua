return {
  "ThorstenRhau/token",
  lazy = false,
  priority = 1000,

  config = function()
    local token = require("token")

    ---@type token.Config
    local config = {
      transparent = true,

      plugins = {
        blink = true,
      },

      -- Transparent mode strips the theme's own backgrounds from the blink.cmp
      -- windows; restore solid backgrounds for just the completion menu + docs.
      on_highlights = function(hl, c)
        -- Solid backgrounds for floating windows (Lazy, Mason, LSP hover, ...)
        -- so the buffer behind doesn't bleed through.
        hl.NormalFloat = { fg = c.fg0, bg = c.bg1 }
        hl.FloatBorder = { fg = c.fg3, bg = c.bg1 }
        hl.FloatTitle = { fg = c.fg0, bg = c.bg1 }

        hl.BlinkCmpMenu = { fg = c.fg0, bg = c.bg1 }
        hl.BlinkCmpMenuBorder = { fg = c.fg3, bg = c.bg1 }
        hl.BlinkCmpScrollBarGutter = { bg = c.bg2 }
        hl.BlinkCmpDoc = { fg = c.fg0, bg = c.bg0 }
        hl.BlinkCmpDocBorder = { fg = c.fg3, bg = c.bg0 }
        hl.BlinkCmpDocSeparator = { fg = c.fg3, bg = c.bg0 }
      end,
    }

    token.setup(config)

    vim.cmd.colorscheme("token-flint")
  end,
}
