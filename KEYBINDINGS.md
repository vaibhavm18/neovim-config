# Keybindings

> Leader = `Space`

## General

| Key | Mode | Action |
|---|---|---|
| `<leader>w` | n | Save file |
| `<leader>W` | n | Save all files |
| `<leader>so` | n | Source current file |
| `<leader>h` | n | Clear search highlight |
| `<C-]>` | all | Escape |

## Clipboard & Registers

| Key | Mode | Action |
|---|---|---|
| `<leader>y` | n, v | Yank to system clipboard |
| `<leader>Y` | n | Yank to end of line (clipboard) |
| `<leader>p` | n, v | Paste from system clipboard |
| `<leader>P` | n, v | Paste before (clipboard) |
| `<leader>d` | n, v | Delete without copying |
| `<leader>D` | n | Delete to end of line (no copy) |
| `<leader>rp` | x | Replace selection with paste, keep register |

## Movement & Editing

| Key | Mode | Action |
|---|---|---|
| `J` / `K` | v | Move selected lines down / up |
| `J` | n | Join line, keep cursor |
| `<C-d>` / `<C-u>` | n | Half-page down / up, centered |
| `n` / `N` | n | Next / prev search match, centered |

## Find (fzf-lua)

| Key | Mode | Action |
|---|---|---|
| `<leader>ff` | n | Find files |
| `<leader>fg` | n | Live grep |
| `<leader>fb` | n | Buffers |
| `<leader>fh` | n | Help tags |

## Files & Tools

| Key | Mode | Action |
|---|---|---|
| `-` | n | Open parent directory (Oil) |
| `<leader>u` | n | Toggle undotree |

## Harpoon

| Key | Mode | Action |
|---|---|---|
| `<leader>ma` | n | Add file to harpoon |
| `<leader>mo` | n | Open harpoon menu |
| `<leader>mr` | n | Remove all harpoon files |
| `<C-j>` / `<C-k>` / `<C-h>` / `<C-s>` | n | Jump to harpoon file 1 / 2 / 3 / 4 |

## Git

| Key | Mode | Action |
|---|---|---|
| `<leader>lg` | n | Open LazyGit |
| `<leader>gg` | n | `:Git` command |
| `]g` / `[g` | n | Next / prev hunk (gitsigns) |
| `<leader>gp` | n | Preview hunk |
| `<leader>gs` | n, v | Stage hunk |
| `<leader>gr` | n, v | Reset hunk |
| `<leader>gS` | n | Stage buffer |
| `<leader>gR` | n | Reset buffer |
| `<leader>gu` | n | Undo stage hunk |
| `<leader>gb` | n | Blame line (full) |
| `<leader>gB` | n | Toggle current-line blame |
| `<leader>gd` | n | Diff this |
| `<leader>gD` | n | Diff this against `~` |
| `ih` | o, x | Select hunk (text object) |

## LSP

> Buffer-local, active when an LSP server attaches

| Key | Mode | Action |
|---|---|---|
| `gR` | n | Show references (fzf-lua) |
| `gD` | n | Go to declaration |
| `gd` | n | Show definitions (fzf-lua) |
| `gri` | n | Show implementations (fzf-lua) |
| `grt` | n | Show type definitions (fzf-lua) |
| `<leader>vca` | n, v | Code action |
| `<leader>rn` | n | Smart rename |
| `<leader>fd` | n | Buffer diagnostics (fzf-lua) |
| `df` | n | Line diagnostics (float) |
| `K` | n | Hover docs |
| `<C-h>` | i | Signature help |

## Formatting (conform.nvim)

| Key | Mode | Action |
|---|---|---|
| `<leader>mp` | n, v | Format file / selection |

## Mini.nvim

| Key | Mode | Action |
|---|---|---|
| `gcc` | n | Comment line |
| `gc` | n, v | Comment (motion / selection) |
| `<M-h/j/k/l>` | n, v | Move line / selection |
| `sa` | n, v | Add surround |
| `sd` | n | Delete surround |
| `sr` | n | Replace surround |

## Completion (blink.cmp)

| Key | Mode | Action |
|---|---|---|
| `<C-n>` / `<C-p>` | i | Next / prev item |
| `<C-y>` | i | Accept |
| `<C-e>` | i | Close menu |
| `<C-space>` | i | Show menu / toggle docs |
| `<C-u>` / `<C-d>` | i | Scroll docs up / down |
| `<Tab>` / `<S-Tab>` | i | Snippet jump forward / back |
