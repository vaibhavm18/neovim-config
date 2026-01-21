# Tmux Keybindings Cheat Sheet

Prefix key: **Ctrl + a**

---

## 🔧 TPM (Tmux Plugin Manager)
| Action | Keybinding | Description |
|---------|-------------|-------------|
| Install plugins | `C-a I` | Install all plugins listed in config |
| Update plugins | `C-a U` | Update all plugins |
| Clean plugins | `C-a M-u` | Remove unused plugins |

---

## ⚙️ Configuration
| Action | Keybinding | Description |
|---------|-------------|-------------|
| Reload config | `C-a r` | Reload `~/.config/tmux/tmux.conf` |

---

## 🧩 Sessions
| Action | Keybinding / Command | Description |
|---------|----------------------|-------------|
| New session | `tmux new -s <name>` or `C-a : new -s <name>` | Create new session |
| List sessions | `C-a s` | Show all sessions |
| Detach | `C-a d` | Detach from tmux |
| Attach | `tmux attach -t <name>` | Reattach to session |

---

## 🪟 Windows
| Action | Keybinding | Description |
|---------|-------------|-------------|
| New window | `C-a c` | Create new window |
| Next window | `C-a n` | Move to next window |
| Previous window | `C-a p` | Move to previous window |
| Select by number | `C-a 1..9` | Jump to numbered window |
| Last window | `C-a l` | Toggle to last window |
| Rename window | `C-a ,` | Rename current window |
| Kill window | `C-a &` | Close current window |
| Find window | `C-a f` | Search for a window |
| List windows | `C-a w` | Choose window from list |

---

## 🔲 Panes
| Action | Keybinding | Description |
|---------|-------------|-------------|
| Split horizontally | `C-a |` | Split pane left/right |
| Split vertically | `C-a -` | Split pane top/bottom |
| Focus left | `C-a h` | Move focus left |
| Focus down | `C-a j` | Move focus down |
| Focus up | `C-a k` | Move focus up |
| Focus right | `C-a l` | Move focus right |
| Toggle zoom | `C-a m` | Maximize/restore pane |
| Show pane numbers | `C-a q` | Display pane numbers |
| Kill pane | `C-a x` | Close current pane |
| Last pane | `C-a ;` | Switch to last active pane |
| Swap panes | `C-a {` / `C-a }` | Swap with adjacent pane |
| Rotate panes | `C-a C-o` | Rotate pane positions |
| Break pane to window | `C-a !` | Turn pane into window |

---

## 📋 Copy Mode (Vi)
| Action | Keybinding | Description |
|---------|-------------|-------------|
| Enter copy mode | `C-a [` | Start copy mode |
| Begin selection | `v` | Start visual selection |
| Rectangle selection | `C-v` | Toggle block selection |
| Yank and exit | `y` | Copy selection and leave mode |
| Paste | `C-a ]` | Paste buffer contents |

---

## 🖱️ Mouse
| Action | Description |
|---------|-------------|
| Click pane | Select pane |
| Drag border | Resize pane |
| Click window list | Switch window |

---

## 📚 Miscellaneous
| Action | Keybinding | Description |
|---------|-------------|-------------|
| Send literal prefix | `C-a C-a` | Send Ctrl+a to application |
| List key bindings | `C-a ?` | Show all keybindings |
| Cycle layouts | `C-a Space` | Change pane layout |

---

## 🧠 Notes
- Base index starts at **1** for windows and panes.
- Prefix key has been changed from default `C-b` to `C-a`.
- Plugins loaded via TPM on config reload.

---

**File location:** `~/.config/tmux/tmux.conf`

