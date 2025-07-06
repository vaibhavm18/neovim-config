return {
  "rmagatti/auto-session",
  config = function()
    -- Preserve buffer-local settings across sessions
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

    require("auto-session").setup({
      -- Disable auto-restore on startup
      auto_restore    = false,                              -- use 'auto_restore', not 'auto_restore_enabled' :contentReference[oaicite:5]{index=5}
      -- Do not auto-save sessions in home, Dev, Downloads, etc.
      suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },  -- use 'suppressed_dirs' :contentReference[oaicite:6]{index=6}

      -- (Optional) Customize where session files are stored
      -- session_dir = vim.fn.stdpath("data") .. "/sessions/",

      -- (Optional) Enable automatic cwd-based session handling
      -- cwd_change_handling = false,
    })

    local map = vim.keymap.set
    -- Restore the last session for the current working directory
    map("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
    -- Save a session for the current working directory
    map("n", "<leader>ws", "<cmd>SessionSave<CR>",    { desc = "Save session for cwd" })
  end,
}
