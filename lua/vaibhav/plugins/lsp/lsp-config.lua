local settings = {
  theme = "neofusion", -- ayu|gruvbox|neofusion
  indentChar = "│", -- │, |, ¦, ┆, ┊
  separatorChar = "-", -- ─, -, .
  aspect = "clean", -- normal|clean
  lualine_separator = "rect", -- rect|triangle|semitriangle|curve
  cmp_style = "nvchad", -- default|nvchad
  cmp_icons_style = "vscode", -- devicons|vscode
  transparent_mode = true,
}

-- for conciseness
local opt = vim.opt -- vim options

-- set options
opt.completeopt = "menu,menuone,noselect"

-- vscode like icons
local cmp_kinds = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    "roobert/tailwindcss-colorizer-cmp.nvim",
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()


    -- require luasnip
    local luasnip = require("luasnip")

    -- require lspkind
    local lspkind = require("lspkind")

    -- require tailwind colorizer for cmp
    local tailwindcss_colorizer_cmp = require("tailwindcss-colorizer-cmp")

    require("conform").setup({
      formatters_by_ft = {
      }
    })
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "gopls",
      },
      handlers = {
        ["rust_analyzer"] = function() end,      -- lspconfig name
        ["rust-analyzer"] = function() end,
        function(server_name) -- default handler (optional)
          if server_name == "rust_analyzer" then
            return  -- <<<  SKIP.  rustaceanvim will attach its own client.
          end
          if server_name == "rust-analyzer" then
            return  -- <<<  SKIP.  rustaceanvim will attach its own client.
          end
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        zls = function()
          local lspconfig = require("lspconfig")
          lspconfig.zls.setup({
            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
            settings = {
              zls = {
                enable_inlay_hints = true,
                enable_snippets = true,
                warn_style = true,
              },
            },
          })
          vim.g.zig_fmt_parse_errors = 0
          vim.g.zig_fmt_autosave = 0

        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                format = {
                  enable = true,
                  -- Put format options here
                  -- NOTE: the value should be STRING!!
                  defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                  }
                },
              }
            }
          }
        end,
      }
    })

    local keymap = vim.keymap
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local buf = ev.buf
        local opts = { buffer = buf, silent = true }

        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
        keymap.set("n", "<leader>tp", vim.diagnostic.open_float, opts)
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    cmp.setup({
      window = {
        completion = {
          border = "rounded", -- single|rounded|none
          -- custom colors
          -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          side_padding = settings.cmp_style == "default" and 1 or 0, -- padding at sides
          col_offset = settings.cmp_style == "default" and -1 or -4, -- move floating box left or right
        },
        documentation = {
          border = "rounded", -- single|rounded|none
          -- custom colors
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None", -- BorderBG|FloatBorder
        },

      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- select previous suggestion
        ["<S-tab>"] = cmp.mapping.select_prev_item(), -- select previous suggestion (2)
        ["<C-j>"] = cmp.mapping.select_next_item(), -- select next suggestion
        ["<tab>"] = cmp.mapping.select_next_item(), -- select next suggestion (2)
        ["<C-l>"] = cmp.mapping.scroll_docs(-4), -- scroll docs down
        ["<C-h>"] = cmp.mapping.scroll_docs(4), -- scroll docs up
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- confirm suggestion
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- lsp
        { name = "luasnip" }, -- luasnips
        { name = "buffer" }, -- text within the current buffer
        { name = "path" }, -- file system paths
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        expandable_indicator = true,
        format = function(entry, item)
          -- vscode like icons for cmp autocompletion
          local fmt = lspkind.cmp_format({
            -- with_text = false, -- hide kind beside the icon
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            before = tailwindcss_colorizer_cmp.formatter, -- prepend tailwindcss-colorizer
          })(entry, item)

          -- customize lspkind format
          local strings = vim.split(fmt.kind, "%s", { trimempty = true })

          -- strings[1] -> default icon
          -- strings[2] -> kind

          -- set different icon styles
          if settings.cmp_icons_style == "vscode" then
            fmt.kind = " " .. (cmp_kinds[strings[2]] or "") -- concatenate icon based on kind
          else
            fmt.kind = " " .. (strings[1] or "") -- just use the default icon
          end

          -- append customized kind text
          if settings.cmp_style == "nvchad" then
            fmt.kind = fmt.kind .. " " -- just an extra space at the end
            fmt.menu = strings[2] ~= nil and ("  " .. (strings[2] or "")) or ""
          else
            -- default and others
            fmt.menu = strings[2] ~= nil and (strings[2] or "") or ""
          end

          return fmt
        end,
      },
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
    },
    })
  end
}
