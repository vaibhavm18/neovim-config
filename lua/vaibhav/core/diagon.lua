-------------------------------------------------------------------------------
-- 1. Global defaults (inline bubbles everywhere)
-------------------------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = true,   -- inline bubbles
  virtual_lines = false,                          -- not using them
  underline = true,
  update_in_insert = true,
  float = {                                       -- default for every float
    border = "rounded",
    source = "if_many",                            -- show which LSP
  },
})

-------------------------------------------------------------------------------
-- 2. Hide the inline bubble on the cursor line
-------------------------------------------------------------------------------
-- local vt_cache
-- vim.api.nvim_create_autocmd({ "CursorMoved", "DiagnosticChanged" }, {
--   group = vim.api.nvim_create_augroup("hide_cursorline_bubble", {}),
--   callback = function()
--     vt_cache = vt_cache or vim.diagnostic.config().virtual_text
--     local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
--     local has_diag = not vim.tbl_isempty(
--       vim.diagnostic.get(0, { lnum = lnum, severity = { min = vim.diagnostic.severity.WARN } })
--     )
--     vim.diagnostic.config({ virtual_text = has_diag and false or vt_cache })
--   end,
-- })

-------------------------------------------------------------------------------
-- 3. Show a floating window immediately on any line with Error | Warning
-------------------------------------------------------------------------------
local float_win
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = vim.api.nvim_create_augroup("auto_float_diagnostics", {}),
  callback = function()
    -- close an old float if it’s still open
    if float_win and vim.api.nvim_win_is_valid(float_win) then
      vim.api.nvim_win_close(float_win, true)
    end

    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
    local diag  = vim.diagnostic.get(0, {
      lnum = lnum,
      severity = { min = vim.diagnostic.severity.WARN },  -- only Err + Warn
    })
    if vim.tbl_isempty(diag) then
      return  -- nothing to show on this line
    end

    float_win = vim.diagnostic.open_float(nil, {
      scope       = "cursor",
      focusable   = false,
      close_events = { "CursorMoved", "BufLeave", "InsertEnter", "WinLeave" },
    })
  end,
})

-------------------------------------------------------------------------------
-- 4. Force a redraw when you change mode (prevents stale bubbles)
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("ModeChanged", {
  group = vim.api.nvim_create_augroup("diagnostic_redraw_on_mode", {}),
  callback = function() pcall(vim.diagnostic.show) end,
})

local map = { ['true']='false',  ['false']='true',
              ['True']='False',  ['False']='True',
              ['yes']='no',      ['no']='yes' }

local function toggle()
  local w = vim.fn.expand('<cword>')
  local repl = map[w]
  if repl then vim.cmd('normal! ciw' .. repl) end
end
vim.keymap.set('n', '<leader>tt', toggle, { desc = 'Toggle boolean-like words' })


