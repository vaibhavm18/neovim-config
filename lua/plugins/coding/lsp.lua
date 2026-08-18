return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "saghen/blink.cmp",
  },

  config = function()
    local cap = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require("blink.cmp").get_lsp_capabilities(cap)

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },

          workspace = {
            library = {
              vim.env.VIMRUNTIME,
            },
          },

          diagnostics = {
            globals = {
              "vim",
            },
          },

          hint = {
            enable = true,
          },
        },
      },
    })

    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          gofumpt = true,

          staticcheck = true,

          analyses = {
            unusedparams = true,
          },

          hints = {
            parameterNames = true,
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            rangeVariableTypes = true,
          },
        },
      },
    })

    vim.lsp.enable({
      "lua_ls",
      "gopls",
    })

    -- NOTE: LSP Custom Keybinds
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        -- Buffer local mappings
        local opts = { buffer = ev.buf, silent = true }

        -- Keymaps
        opts.desc = "Show LSP references"
        vim.keymap.set("n", "gR", function() require("fzf-lua").lsp_references() end, opts)

        opts.desc = "Go to declaration"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        vim.keymap.set("n", "gd", function() require("fzf-lua").lsp_definitions() end, opts)

        opts.desc = "Show LSP implementations"
        vim.keymap.set("n", "gri", function() require("fzf-lua").lsp_implementations() end, opts)

        opts.desc = "Show LSP type definitions"
        vim.keymap.set("n", "grt", function() require("fzf-lua").lsp_typedefs() end, opts)

        opts.desc = "See available code actions"
        vim.keymap.set({ "n", "v" }, "<leader>vca", function() vim.lsp.buf.code_action() end, opts)

        opts.desc = "Smart rename"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        vim.keymap.set("n", "<leader>fd", function() require("fzf-lua").diagnostics_document() end, opts)

        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "df", function() vim.diagnostic.open_float() end, opts)

        opts.desc = "Show documentation for what is under cursor"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Show signature help"
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      end,
    })
  end,
}
