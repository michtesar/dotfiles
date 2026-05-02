# dotfiles

Personal macOS dotfiles.

Managed by `chezmoi`.

Source lives here:

```sh
~/Developer/dotfiles
```

Check it:

```sh
chezmoi source-path
chezmoi git -- status
```

## Install

Fresh machine:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/michtesar/dotfiles/main/install.sh)"
```

That installs the basics, applies dotfiles, runs Homebrew bundles, installs VS
Code extensions, sets up tmux plugins, and applies a few macOS defaults.

## Daily Flow

Edit the real config. The one the app actually reads.

Example:

```sh
vim ~/.config/btop/btop.conf
```

See what changed:

```sh
chezmoi diff ~/.config/btop/btop.conf
```

Import it into the repo:

```sh
chezmoi add ~/.config/btop/btop.conf
```

Commit it:

```sh
chezmoi git -- status
chezmoi git -- diff
chezmoi git -- add .
chezmoi git -- commit -m "Update btop config"
chezmoi git -- push
```

That is the whole game.

## Pull Changes

```sh
chezmoi update
```

That pulls from GitHub and applies the result.

## Open Repo

```sh
chezmoi cd
```

## Managed

- `~/.zshrc`
- `~/.zprofile`
- `~/.config/btop`
- `~/.config/homebrew`
- `~/.config/nvim`
- `~/.config/tmux`
- `~/.local/bin/dotfiles-*`
- `~/Library/Application Support/Code/User/settings.json`
- `~/Library/Application Support/Code/User/keybindings.json`
- `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`
- `~/Library/Preferences/DOSBox/dosbox-staging.conf`

VS Code extensions are tracked as source data in:

```sh
vscode/extensions.txt
```

Refresh them:

```sh
code --list-extensions | sort > "$(chezmoi source-path)/vscode/extensions.txt"
chezmoi git -- add vscode/extensions.txt
chezmoi git -- commit -m "Update VS Code extensions"
chezmoi git -- push
```

## Not Managed

Do not put this stuff in here:

- secrets
- SSH keys
- shell history
- `gh` auth
- app caches
- workspace state
- tmux plugin checkouts
- VS Code `globalStorage`, `workspaceStorage`, `History`
- anything that smells like a token

If it feels private, it is private. Do not commit it.

## Useful Commands

```sh
chezmoi managed
chezmoi status
chezmoi diff
chezmoi apply
chezmoi git -- status
```

## Add New File

```sh
chezmoi add ~/.config/some-tool/config.toml
chezmoi git -- status
chezmoi git -- diff
chezmoi git -- add .
chezmoi git -- commit -m "Add some-tool config"
chezmoi git -- push
```

## Stop Tracking A File

Keep the file on disk, remove it from dotfiles:

```sh
chezmoi forget ~/.config/some-tool/config.toml
chezmoi git -- add -A
chezmoi git -- commit -m "Stop tracking some-tool config"
chezmoi git -- push
```

## Homebrew

```sh
dotfiles-brew
dotfiles-brew --mas
```

## tmux

Install plugins:

```sh
dotfiles-tmux-plugins
```

Inside tmux:

```text
prefix + I
```

Prefix is `Ctrl-a`.
