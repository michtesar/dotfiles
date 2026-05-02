# nvim

My Neovim config. Fast enough, boring enough, useful enough.

Leader is `<Space>`.

## Shape

```text
init.lua                  loads the config
lua/config/options.lua    editor defaults
lua/config/keymaps.lua    keymaps
lua/config/commands.lua   toggles and custom commands
lua/config/autocmds.lua   autocmds
lua/config/lazy.lua       plugin bootstrap
lua/config/theme.lua      Catppuccin + macOS light/dark
lua/config/alpha.lua      startup screen
```

## Install

```sh
brew install git ripgrep fd uv ruff biome taplo lazygit make
nvim
```

Then inside Neovim:

```vim
:Lazy sync
:Mason
:checkhealth
```

## What It Does

- Catppuccin, matching macOS light/dark
- Telescope for files, grep, buffers, old files
- Neo-tree for a file tree
- LSP, format-on-save, diagnostics
- Ruff, Biome, Taplo
- LazyGit and LazyDocker terminals
- Trouble for diagnostics and references
- A focus mode when the screen gets loud

## Keys

```text
<leader>ff  find files
<leader>fg  live grep
<leader>fb  buffers
<leader>fr  recent files
<leader>.   recent files, fast
<leader>n   file tree

gd          definition
gr          references
K           hover
<leader>ca  code action
<leader>rn  rename
<leader>f   format

<leader>td  toggle inline diagnostics
<leader>tf  toggle format on save
<leader>tz  focus mode
<leader>tZ  focus mode off

<leader>gg  LazyGit
<leader>gd  LazyDocker
<leader>db  database UI
<leader>ao  OpenCode
```

Arrow keys are disabled. Use hjkl. It is fine.

## Commands

```vim
:Theme system
:Theme light
:Theme dark
:DiagnosticsToggle
:FormatOnSaveToggle
:FocusMode
:FocusModeOff
```

## Rules

- Put options in `options.lua`.
- Put keymaps in `keymaps.lua`.
- Put commands in `commands.lua`.
- Keep comments short.
- Do not add plugins unless they earn the rent.
