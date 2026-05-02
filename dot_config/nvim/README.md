# Professional Neovim Setup (JetBrains-friendly, Neovim-native)

This config is tuned for a clean IDE-like experience with strong defaults and minimal friction when using other people's Neovim setups.

It focuses on:

- Fast project navigation (file explorer + fuzzy find + recent files)
- Strong Python and web tooling (`ty`, `ruff`, `biome`, `uv`)
- Git-heavy workflows (`gitsigns`, `lazygit`)
- Optional Docker, DB, and AI-agent integrations
- Toggleable diagnostics/noise for focused writing sessions

## Design principles

- Keep Neovim defaults where practical
- Add IDE workflows mostly behind `<leader>` keymaps
- Optimize for single-window work (no split-heavy UX)
- Keep config modular and easy to extend by humans and AI agents

## Repository layout

- `init.lua` bootstrap
- `lua/config/options.lua` core editor options
- `lua/config/keymaps.lua` keymaps
- `lua/config/commands.lua` toggles and helper commands
- `lua/config/autocmds.lua` autocmds
- `lua/config/lazy.lua` plugin manager setup
- `lua/plugins/editor.lua` UI/navigation/git/docker/db/markdown plugins
- `lua/plugins/lsp.lua` LSP/completion/format/lint stack

## Prerequisites

Install required CLIs:

```bash
brew install git ripgrep fd uv ruff biome taplo lazygit make
```

Install Python language server in your project or globally:

```bash
uv add --dev ty
```

Optional but recommended:

```bash
brew install lazydocker
```

For database workflows, install your DB client binaries as needed (`psql`, `mysql`, `sqlite3`, etc.).

## First run

1. Start Neovim:
   - `nvim`
2. Install/sync plugins:
   - `:Lazy sync`
3. Install language servers/tools from Mason:
   - `:Mason`
   - Ensure: `ruff`, `biome`, `lua_ls`, `jsonls`, `yamlls`, `taplo`, `dockerls`, `marksman`
4. Verify health:
   - `:checkhealth`

## Core features

- File explorer: `neo-tree`
- Fuzzy find/live grep/recent files: `telescope`
- Recent files quick access (JetBrains-like "recent files"): `<leader>.`
- Rich UI: `lualine`, `noice`, `notify`, `which-key`
- Diagnostics list and references list: `trouble`
- Git signs/blame/hunks: `gitsigns`
- Floating terminals for `lazygit`, `lazydocker`, `bmind`, `opencode`: `toggleterm`
- Markdown rendering in-buffer: `render-markdown.nvim`
- Database UI: `vim-dadbod-ui`
- Docstring generation: `neogen`

## Python workflow (`ty` + `ruff` + `uv`)

Python language server is explicitly configured as `ty` (no basedpyright):

- LSP command: `uv run ty server`
- Diagnostics and code actions: `ty` + `ruff` LSP
- Formatting: `ruff_format` via `conform.nvim`

This keeps tooling aligned with project-local dependencies managed by `uv`.

## Formatting and linting

- Format key: `<leader>f`
- Format-on-save: enabled by default
- Toggle format-on-save: `<leader>tf`
- JS/TS/JSON: `biome`
- Python: `ruff_format`
- TOML: `taplo`

Lint and diagnostics are provided by LSP servers to avoid duplicate messages and reduce editor churn.

## Diagnostics and focus mode

- Inline diagnostics are enabled while typing (`update_in_insert = true`)
- Toggle inline diagnostics virtual text: `<leader>td`
- Enter focus mode: `<leader>tz`
- Exit focus mode: `<leader>tZ`

Focus mode turns off visual noise in the current window (numbers/signcolumn/cursorline + inline diagnostics).
Diagnostics are disabled and restored per buffer to avoid impacting other open files.

## Keymaps (leader is `<Space>`)

Navigation/search:

- `<leader>ff` find files
- `<leader>fg` live grep
- `<leader>fb` buffers
- `<leader>fr` recent files
- `<leader>.` quick recent files
- `<leader>n` toggle file explorer

Code/LSP:

- `gd` definition
- `gD` declaration
- `gr` references
- `gi` implementation
- `K` hover docs
- `<C-k>` signature help
- `<leader>ca` code action
- `<leader>rn` rename
- `<leader>f` format buffer
- `<leader>cg` generate docstring/comment (`Neogen`)

Diagnostics:

- `[d` previous diagnostic
- `]d` next diagnostic
- `<leader>e` line diagnostic float
- `<leader>xx` diagnostics list (`Trouble`)
- `<leader>xr` references list (`Trouble`)

Git/DevOps/DB/AI:

- `<leader>gg` `LazyGit`
- `<leader>gd` `LazyDocker`
- `<leader>db` `DBUI`
- `<leader>ac` toggle BeMind terminal (compat key)
- `<leader>ab` toggle BeMind terminal
- `<leader>ao` toggle OpenCode terminal

Editor basics:

- `<leader>w` save
- `<leader>q` quit window
- `<Esc>` clear search highlight
- Arrow keys are disabled in normal/visual/insert modes

## Useful commands

- `:Lazy` plugin manager UI
- `:Mason` LSP/tool manager UI
- `:LspInfo` active LSPs
- `:ConformInfo` formatter state
- `:DiagnosticsOn` / `:DiagnosticsOff` / `:DiagnosticsToggle`
- `:FormatOnSaveOn` / `:FormatOnSaveOff` / `:FormatOnSaveToggle`
- `:FocusMode` / `:FocusModeOff`

## Notes for AI agents and future maintenance

- Prefer adding new plugins in existing grouped files (`lua/plugins/editor.lua`, `lua/plugins/lsp.lua`) unless a new domain appears.
- Put keybindings in `lua/config/keymaps.lua` and user commands/toggles in `lua/config/commands.lua`.
- Keep comments short and only for non-obvious logic.
- Run `:checkhealth`, `:LspInfo`, and `:ConformInfo` after larger changes.
