return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  -- Use a release tag so the prebuilt fuzzy-matcher binary is downloaded
  version = "1.*",
  event = "InsertEnter",

  opts = {
    keymap = {
      -- "enter" preset: <CR> accepts the selected item (instead of <C-y>),
      -- Up/Down and <C-n>/<C-p> navigate, Tab/S-Tab jump snippet placeholders
      preset = "enter",

      -- Docs: <C-space> toggles the doc window (preset default),
      -- <C-u>/<C-d> scroll it (<C-b>/<C-f> from the preset also work)
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    cmdline = { completion = { ghost_text = { enabled = true } } },

    completion = {
      documentation = {
        auto_show = true,
      },
    },

    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
      },
    },

    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },
  },
}
