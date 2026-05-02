# dotfiles

Personal macOS dotfiles managed by [chezmoi](https://www.chezmoi.io/).

This repository is public by design. It contains configuration only: no tokens,
no app state, no shell history, no `gh` auth, and no opencode config.

## New Mac

Run the bootstrap script from a fresh macOS install:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/michtesar/dotfiles/main/install.sh)"
```

The bootstrap installs Homebrew and chezmoi when needed, applies this repo, then
runs the small post-install helpers.

## What Is Managed

- Homebrew manifests in `~/.config/homebrew`
- Zsh: `~/.zshrc`, `~/.zprofile`
- Neovim: `~/.config/nvim`
- tmux: `~/.config/tmux`
- btop: `~/.config/btop`
- Ghostty: `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`
- DOSBox Staging: `~/Library/Preferences/DOSBox/dosbox-staging.conf`
- VS Code user settings and extension list
- A small macOS defaults helper

## What Is Not Managed

- `~/.config/gh`
- opencode config
- SSH keys and secrets
- application caches, histories, sessions, and generated state
- tmux plugin checkouts
- VS Code `globalStorage`, `workspaceStorage`, and `History`

## Homebrew

Homebrew manifests live under `~/.config/homebrew`:

```text
Brewfile      core CLI/dev tools
Brewfile.gui  GUI apps and fonts
Brewfile.mas  Mac App Store apps, optional and best-effort
```

Run the default bundles:

```sh
dotfiles-brew
```

Run the Mac App Store bundle explicitly:

```sh
dotfiles-brew --mas
```

`mas` can fail even when the App Store GUI is signed in. If it does, sign in
manually, open the App Store once, and rerun the MAS command.

## VS Code

Install extensions from the recorded list:

```sh
dotfiles-vscode-extensions
```

Refresh the recorded extension list:

```sh
code --list-extensions | sort > "$(chezmoi source-path)/vscode/extensions.txt"
```

## macOS Defaults

Apply the small set of personal macOS preferences:

```sh
dotfiles-macos-defaults
```

This currently covers tap-to-click, text correction settings, and the current
US/Czech keyboard input source list.

## tmux Plugins

tmux plugins are not committed. Install TPM and declared plugins with:

```sh
dotfiles-tmux-plugins
```

## Daily Chezmoi Workflow

Edit a managed file:

```sh
chezmoi edit ~/.zshrc
chezmoi apply
```

See pending changes:

```sh
chezmoi diff
```

Commit changes:

```sh
chezmoi cd
git status
git add .
git commit -m "Update dotfiles"
git push
```
