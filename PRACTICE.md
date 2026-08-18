# Practice Drills

> Do one session a day (5–10 min) inside a real project (a git repo with Go or Lua files).
> Don't peek at KEYBINDINGS.md until you're stuck for 5+ seconds — recalling is what builds memory.
> Leader = `Space`.

## Warm-up (every session, ~1 min)

1. Open a project: `nvim .`
2. Find a file: `<leader>ff`, type a few letters, Enter.
3. Make a small edit, save with `<leader>w`.
4. Search for a word with `/`, jump with `n` / `N` (notice it stays centered).
5. Clear the highlight: `<leader>h`.
6. Exit insert mode with `<C-]>` instead of Escape — every time, all session.

## Day 1 — Files: Oil + fzf

1. Press `-` to open the parent directory (Oil).
2. In Oil, create a file `scratch.lua` (just type the name like editing text, then `<leader>w` to save the listing — Oil applies it).
3. Rename it in Oil the same way (edit the line, save). Delete it (dd the line, save).
4. `<leader>ff` → open a file. `<leader>fb` → switch between your open buffers.
5. `<leader>fg` → live-grep for a function name you know exists. Jump to it.
6. `<leader>fh` → search help for `oil`, read 10 seconds, close.

## Day 2 — Harpoon

1. Open 4 files you use often. On each: `<leader>ma` to harpoon it.
2. `<leader>mo` — look at the list, close it.
3. Jump between them: `<C-j>` (1), `<C-k>` (2), `<C-h>` (3), `<C-s>` (4).
   Do 10 jumps without opening the menu.
4. Reorder the list from `<leader>mo` (edit lines, save, quit the menu).
5. `<leader>mr` to clear all, then re-add your real working set.

**Goal:** stop using `<leader>fb` for your core 4 files — harpoon them instead.

## Day 3 — Git: gitsigns + lazygit

1. Edit 3 different spots in a tracked file (don't save a commit).
2. Jump between hunks: `]g` and `[g`.
3. On a hunk: `<leader>gp` to preview it.
4. Stage one hunk with `<leader>gs`. Reset another with `<leader>gr`.
5. Undo the stage: `<leader>gu`.
6. `<leader>gb` — who last touched this line? `<leader>gB` to toggle inline blame, look around, toggle it off.
7. `<leader>gd` — diff the file. Close the diff.
8. Select a hunk as a text object: put cursor in a hunk, `vih`, then Escape.
9. Open `<leader>lg` (LazyGit): stage the rest, write a commit, then press `?` inside LazyGit to see its own keys. Quit with `q`.

## Day 4 — LSP (open a Go or Lua file)

1. Put cursor on a function call: `K` for docs, `gd` for definition, `<C-o>` to jump back.
2. `gR` — see all references. `gri` — implementations (Go interfaces are great for this).
3. `gD` declaration, `grt` type definition.
4. Rename a local variable with `<leader>rn`, then undo.
5. Break something (misspell a variable). Jump to the error, `df` for the floating diagnostic, `<leader>fd` for the buffer list. Fix it.
6. `<leader>vca` on something underlined — try a code action, undo.
7. In insert mode inside a function call, press `<C-h>` for signature help.
8. Notice the inlay hints (grey parameter names/types). Toggle them:
   `:lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())`
9. Format the mess you made: `<leader>mp`. Save all: `<leader>W`.

## Day 5 — Editing: mini.nvim + registers

1. Select 3 lines with `V`, move them down/up with `J` / `K`. Then try `<M-j>` / `<M-k>` on a single line without selecting.
2. Comment a line with `gcc`. Comment a paragraph with `gcip`. Uncomment both.
3. Surround practice on a word: `saiw"` (add quotes), `sr"'` (swap to single), `sd'` (delete them). Repeat until it's automatic.
4. Yank a line to system clipboard `<leader>y`, paste it in another app. Copy something outside Neovim, paste with `<leader>p`.
5. Delete a line without clobbering your yank: yank line A (`yy`), delete line B with `<leader>d`, paste A with `p` — it's still there.
6. Select a word, replace it with a previous yank using `<leader>rp`, then do it again — register survived.
7. Made a mess? `<leader>u` — walk the undo tree back to a good state.

## Day 6 — Completion (blink.cmp) + flow

1. In insert mode, type slowly: navigate the menu with `<C-n>` / `<C-p>`, accept with `<C-y>`, dismiss with `<C-e>`.
2. `<C-space>` to open the menu manually / toggle docs; scroll docs with `<C-u>` / `<C-d>`.
3. Expand a snippet, jump through placeholders with `<Tab>` / `<S-Tab>`.
4. Full loop, no mouse, no arrow keys: `<leader>ff` → edit → `<C-]>` → `<leader>gs` → `<leader>lg` → commit.

## Day 7 — Cold recall test

Without opening KEYBINDINGS.md, do all of these in under 3 minutes:

- [ ] Harpoon a file and jump to slot 3
- [ ] Grep the project for a word
- [ ] Stage one hunk, preview another
- [ ] Go to a definition and come back
- [ ] Rename a symbol
- [ ] Add surround quotes to a word, then change them
- [ ] Move a visual selection down 3 lines
- [ ] Format the file, save all, open LazyGit, quit

Anything you had to look up → that's tomorrow's warm-up.
