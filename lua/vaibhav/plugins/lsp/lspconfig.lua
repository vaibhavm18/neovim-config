-- ~/.config/nvim/lua/vaibhav/plugins/lsp/lspconfig.lua
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",               -- Mason core
    "williamboman/mason-lspconfig.nvim",     -- Mason <> lspconfig bridge
    "hrsh7th/cmp-nvim-lsp",                  -- LSP completion source
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    ------------------------------------------------------------------
    -- 1. Mason Setup
    ------------------------------------------------------------------
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "gopls",     -- Go
        "emmet_ls",  -- Emmet for HTML/CSS/JSX
        "lua_ls",    -- Lua
        "ts_ls",     -- TypeScript (typescript-language-server)
        "rust_analyzer"
      },
      automatic_installation = true,  -- install servers if missing
      automatic_enable = true,        -- auto-call vim.lsp.enable()
    })

    if vim.lsp.inlay_hint then
  vim.lsp.inlay_hint.enable(true, { 0 })
end


    ------------------------------------------------------------------
    -- 2. Common LSP Attach Keymaps
    ------------------------------------------------------------------
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
        keymap.set({ "n","v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    ------------------------------------------------------------------
    -- 3. Diagnostic Sign Icons
    ------------------------------------------------------------------
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      vim.fn.sign_define(
        "DiagnosticSign" .. type,
        { text = icon, texthl = "DiagnosticSign" .. type, numhl = "" }
      )
    end

    ------------------------------------------------------------------
    -- 4. Capabilities (for nvim-cmp)
    ------------------------------------------------------------------
    local capabilities = vim.tbl_deep_extend("force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )
    -- avoid watchedFiles registration on some servers
    capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

    ------------------------------------------------------------------
    -- 5. Per-Server Configuration
    ------------------------------------------------------------------
    local lspconfig = require("lspconfig")
    local util      = require("lspconfig/util")

    -- Go: gopls
    lspconfig.gopls.setup({
      capabilities = capabilities,
      filetypes    = { "go", "gomod", "gowork", "gotmpl" },
      cmd          = { "gopls" },
      root_dir     = util.root_pattern("go.work", "go.mod", ".git"),
      settings     = {
        gopls = {
          completeUnimported = true,
          usePlaceholders    = true,
          analyses           = { unusedparams = true },
        },
      },
    })

    -- Emmet: emmet_ls
    lspconfig.emmet_ls.setup({
      capabilities = capabilities,
      filetypes    = {
        "html","typescriptreact","javascriptreact",
        "css","sass","scss","less","svelte",
      },
    })


    -- Lua: lua_ls
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion  = { callSnippet = "Replace" },
          workspace   = { library = vim.api.nvim_get_runtime_file("", true) },
        },
      },
    })

    -- TypeScript: ts_ls
    lspconfig.ts_ls.setup({
      capabilities = capabilities,
    })
  end,
}
