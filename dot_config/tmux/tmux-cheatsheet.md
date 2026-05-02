# tmux Cheat Sheet

Print-friendly reference for this tmux setup.

Prefix key: `Ctrl-a`

Most shortcuts below mean: press `Ctrl-a`, release, then press the listed key.

---

## Essentials

| Action | Shortcut / Command |
| --- | --- |
| Send literal prefix to the terminal | `Ctrl-a` then `Ctrl-a` |
| Reload tmux config | `Ctrl-a` then `r` |
| Open tmux command prompt | `Ctrl-a` then `:` |
| Detach from current session | `Ctrl-a` then `d` |
| Show key bindings | `Ctrl-a` then `?` |
| Install TPM plugins | `Ctrl-a` then `I` |
| Update TPM plugins | `Ctrl-a` then `U` |
| Remove unused TPM plugins | `Ctrl-a` then `Alt-u` |
| Toggle Catppuccin light/dark theme | `Ctrl-a` then `T` |

---

## Panes

| Action | Shortcut |
| --- | --- |
| Split horizontally, keeping current directory | `Ctrl-a` then `\|` |
| Split vertically, keeping current directory | `Ctrl-a` then `-` |
| Move to left pane | `Ctrl-a` then `H` |
| Move to lower pane | `Ctrl-a` then `J` |
| Move to upper pane | `Ctrl-a` then `K` |
| Move to right pane | `Ctrl-a` then `L` |
| Resize pane left | `Ctrl-a` then `<` |
| Resize pane right | `Ctrl-a` then `>` |
| Resize pane down | `Ctrl-a` then `_` |
| Resize pane up | `Ctrl-a` then `+` |
| Close current pane | `Ctrl-a` then `x`, then confirm |
| Zoom current pane | `Ctrl-a` then `z` |
| Cycle pane layouts | `Ctrl-a` then `Space` |
| Show pane numbers | `Ctrl-a` then `q` |

Resize bindings are repeatable: after pressing the prefix once, press the resize key repeatedly.

---

## Windows

| Action | Shortcut |
| --- | --- |
| New window, keeping current directory | `Ctrl-a` then `c` |
| Rename current window | `Ctrl-a` then `R` |
| Kill current window | `Ctrl-a` then `k` |
| Next window | `Ctrl-a` then `n` |
| Previous window | `Ctrl-a` then `p` |
| Last active window | `Ctrl-a` then `l` |
| Choose window/session tree | `Ctrl-a` then `s` |
| Go to window number 1-9 | `Ctrl-a` then `1` ... `9` |

Windows and panes start at index `1` in this config.

---

## Sessions

| Action | Command / Shortcut |
| --- | --- |
| Start tmux | `tmux` |
| Start named session | `tmux new -s work` |
| List sessions | `tmux ls` |
| Attach to last session | `tmux attach` |
| Attach to named session | `tmux attach -t work` |
| Rename current session | `Ctrl-a` then `$` |
| Detach from session | `Ctrl-a` then `d` |
| Kill named session | `tmux kill-session -t work` |
| Kill tmux server | `tmux kill-server` |

---

## Copy Mode

| Action | Shortcut |
| --- | --- |
| Enter copy mode | `Ctrl-a` then `[` |
| Start selection | `v` |
| Copy selection and exit | `y` |
| Cancel / leave copy mode | `q` |
| Move like Vim | `h`, `j`, `k`, `l` |
| Search forward | `/` |
| Search backward | `?` |
| Next search result | `n` |
| Previous search result | `N` |

Clipboard integration is provided by `tmux-yank` plus `set-clipboard on`.

---

## Neovim Navigation

This config includes `vim-tmux-navigator`.

| Action | Shortcut |
| --- | --- |
| Move left between Vim/tmux panes | `Ctrl-h` |
| Move down between Vim/tmux panes | `Ctrl-j` |
| Move up between Vim/tmux panes | `Ctrl-k` |
| Move right between Vim/tmux panes | `Ctrl-l` |

These shortcuts work best when the matching Neovim plugin is also installed.

---

## Theme

tmux uses Catppuccin and follows macOS appearance when tmux starts or when the config is reloaded.
You can manually toggle between Latte and Mocha with `Ctrl-a` then `T`.

| macOS Appearance | tmux Theme |
| --- | --- |
| Light | Catppuccin Latte |
| Dark | Catppuccin Mocha |

Manually reload after changing macOS appearance:

```sh
tmux source-file ~/.config/tmux/tmux.conf
```

Or inside tmux:

```text
Ctrl-a then r
```

---

## Useful tmux Commands

| Command | Purpose |
| --- | --- |
| `tmux source-file ~/.config/tmux/tmux.conf` | Reload config from shell |
| `tmux display-message 'text'` | Show a tmux status message |
| `tmux list-keys` | List active key bindings |
| `tmux show-options -g` | Show global options |
| `tmux show-window-options -g` | Show global window options |
| `tmux list-panes` | List panes in current window |
| `tmux list-windows` | List windows in current session |
| `tmux list-sessions` | List sessions |

---

## Configuration Files

| File / Directory | Purpose |
| --- | --- |
| `~/.config/tmux/tmux.conf` | Main tmux configuration |
| `~/.config/tmux/tmux-cheatsheet.md` | This cheat sheet |
| `~/.config/tmux/plugins/` | TPM-managed plugins on this machine |
| `~/.config/tmux/plugins/tpm/` | TPM bootstrap installation |

---

## Mental Model

tmux has three main layers:

| Layer | Meaning |
| --- | --- |
| Session | A workspace that can survive terminal windows closing |
| Window | A tab inside a session |
| Pane | A split inside a window |

Recommended workflow:

1. Start one named session per project.
2. Use windows for major tasks such as editor, server, logs, and shell.
3. Use panes only when simultaneous visibility is useful.
4. Detach instead of closing when you want the workspace to keep running.
