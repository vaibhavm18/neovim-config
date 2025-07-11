-- plugins/rust.lua
return {
  "mrcjkb/rustaceanvim",
  version = "^5",        -- stick to the stable API
  ft = "rust",           -- lazy-load on Rust files
  config = function()
    ---------------------------------------------------------------------------
    -- Shared LSP goodies ------------------------------------------------------
    ---------------------------------------------------------------------------
    local original_capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)

    ---@type rustaceanvim.Opts
    vim.g.rustaceanvim = {
      -- 1. TOOLS (runnables / code-actions UI, etc.)
      tools = {
        enable_clippy = true,                       -- run clippy on save
        code_actions  = { ui_select_fallback = true }, -- nicer grouped actions
      },

      -- 2. SERVER (actual rust-analyzer settings)
      server = {
        capabilities = capabilities,
        on_attach = function(_, bufnr)
          -- quick keymaps – extend as you like
          local nmap = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = "Rust: " .. desc })
          end
          nmap("K",         vim.lsp.buf.hover,         "Hover")
          nmap("<leader>rn", vim.lsp.buf.rename,        "Rename")
          nmap("<leader>ca", vim.lsp.buf.code_action,   "Code Action")
        end,
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            check = { command = "clippy" },            -- same as enable_clippy, but explicit
            diagnostics = { enable = true },
          },
        },
      },

      -- 3. DAP (optional – only if you use nvim-dap)
      dap = {
        autoload_configurations = true,  -- default; set false if you don’t want auto-load
      },
    }
  end,
}

