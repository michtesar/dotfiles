# dotfiles

Personal macOS dotfiles managed with [chezmoi](https://www.chezmoi.io/).

This repository is intentionally public. It contains configuration only: no
tokens, no `gh` auth, no opencode config, no shell history, and no application
runtime state.

## Fresh Mac Setup

Run this on a clean macOS install:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/michtesar/dotfiles/main/install.sh)"
```

The bootstrap script:

1. checks for Xcode Command Line Tools
2. installs Homebrew if needed
3. installs chezmoi if needed
4. applies this repository with `chezmoi`
5. runs the core and GUI Homebrew bundles
6. installs Oh My Zsh, tmux plugins, and VS Code extensions
7. applies a small set of macOS defaults

Mac App Store apps are not installed automatically because `mas` can be flaky
even when the App Store GUI is signed in.

## Chezmoi Mental Model

Chezmoi has two important locations:

```text
target files    the real files read by applications
source state    the git repo chezmoi uses to generate target files
```

Examples of target files:

```text
~/.zshrc
~/.config/tmux/tmux.conf
~/.config/nvim/init.lua
~/Library/Application Support/Code/User/settings.json
```

Find the local source checkout with:

```sh
chezmoi source-path
```

It usually lives at:

```text
~/.local/share/chezmoi
```

If you are using a separate checkout instead of the default source path, pass it
explicitly:

```sh
chezmoi --source /private/tmp/dotfiles-chezmoi-https status
chezmoi --source /private/tmp/dotfiles-chezmoi-https diff ~/.config/tmux/tmux.conf
chezmoi --source /private/tmp/dotfiles-chezmoi-https add ~/.config/tmux/tmux.conf
```

Files in the source repo use chezmoi naming conventions:

```text
dot_zshrc                         -> ~/.zshrc
dot_config/tmux/tmux.conf         -> ~/.config/tmux/tmux.conf
dot_local/bin/executable_foo      -> ~/.local/bin/foo
private_Library/...               -> ~/Library/... with more private permissions
```

In plain terms: applications read normal files from your home directory, but git
truth lives in the chezmoi source repo.

## Managed Files

- Homebrew manifests in `~/.config/homebrew`
- Zsh: `~/.zshrc`, `~/.zprofile`
- Neovim: `~/.config/nvim`
- tmux: `~/.config/tmux`
- btop: `~/.config/btop`
- Ghostty: `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`
- DOSBox Staging: `~/Library/Preferences/DOSBox/dosbox-staging.conf`
- VS Code user settings, keybindings, and extension list
- a small macOS defaults helper

## Unmanaged Files

- `~/.config/gh`
- opencode config
- SSH keys and secrets
- shell history
- application caches, sessions, workspace state, and generated files
- tmux plugin checkouts
- VS Code `globalStorage`, `workspaceStorage`, and `History`

## Homebrew

Homebrew manifests live in:

```text
~/.config/homebrew/Brewfile      core CLI/dev tools
~/.config/homebrew/Brewfile.gui  GUI apps and fonts
~/.config/homebrew/Brewfile.mas  Mac App Store apps
```

Install the default bundles:

```sh
dotfiles-brew
```

Install the Mac App Store bundle explicitly:

```sh
dotfiles-brew --mas
```

If `mas` fails, open the App Store, sign in, visit the Purchased page or the app
page, then try the MAS command again.

## VS Code

Install extensions from the recorded list:

```sh
dotfiles-vscode-extensions
```

Refresh the extension list from the current VS Code install:

```sh
code --list-extensions | sort > "$(chezmoi source-path)/vscode/extensions.txt"
```

Then commit the change from the source repo:

```sh
chezmoi cd
git status
git add vscode/extensions.txt
git commit -m "Update VS Code extensions"
git push
```

## macOS Defaults

Apply personal macOS preferences:

```sh
dotfiles-macos-defaults
```

This currently enables tap-to-click, disables automatic text corrections,
disables period insertion after double-space, and applies the current US/Czech
input source list.

Some macOS changes may require logging out and back in.

## tmux Plugins

Plugin checkouts are not committed. The repository only contains `tmux.conf`,
where plugins are declared.

Install TPM and plugins:

```sh
dotfiles-tmux-plugins
```

Inside a running tmux session, the standard TPM flow also works:

```text
prefix + I      install plugins
prefix + U      update plugins
prefix + alt+u  clean plugins
```

The prefix in this config is `Ctrl-a`.

## Daily Chezmoi Workflow

See what chezmoi manages and what it would apply:

```sh
chezmoi managed
chezmoi diff
```

When working from this repository checkout directly, use the explicit source
path:

```sh
chezmoi --source /private/tmp/dotfiles-chezmoi-https status
chezmoi --source /private/tmp/dotfiles-chezmoi-https diff
```

Apply source state to your home directory:

```sh
chezmoi apply
```

Pull the latest changes from GitHub and apply them:

```sh
chezmoi update
```

Open the source repo:

```sh
chezmoi cd
```

## Commit A Change Made In A Target File

This is the most common workflow: you edit the real config file where the app
reads it, such as `~/.config/tmux/tmux.conf`. Chezmoi can detect that change,
but the git repo does not update by itself. You need to import the target file
back into source state.

### Example: Updating tmux Config

1. Inspect the difference between the target file and source state:

```sh
chezmoi diff ~/.config/tmux/tmux.conf
```

2. If the change looks right, import the current target file into chezmoi
source:

```sh
chezmoi add ~/.config/tmux/tmux.conf
```

3. Move into the source repo:

```sh
chezmoi cd
```

4. Inspect the git diff:

```sh
git status
git diff -- dot_config/tmux/tmux.conf
```

5. Commit and push:

```sh
git add dot_config/tmux/tmux.conf
git commit -m "Update tmux config"
git push
```

The whole flow is:

```text
edit ~/.config/tmux/tmux.conf
chezmoi --source /private/tmp/dotfiles-chezmoi-https diff ~/.config/tmux/tmux.conf
chezmoi --source /private/tmp/dotfiles-chezmoi-https add ~/.config/tmux/tmux.conf
cd /private/tmp/dotfiles-chezmoi-https
git diff
git add .
git commit
git push
```

## Edit Through Chezmoi Directly

Alternatively, edit a managed file through chezmoi:

```sh
chezmoi edit ~/.config/tmux/tmux.conf
chezmoi apply
```

`chezmoi edit` opens the source file. `chezmoi apply` writes it back to the
target location.

This is clean when you know you are editing dotfiles. For normal day-to-day use,
editing the real config and then running `chezmoi add` is also fine.

## Add A New Managed File

To start managing a new config file:

```sh
chezmoi add ~/.config/some-tool/config.toml
chezmoi cd
git status
git add .
git commit -m "Add some-tool config"
git push
```

Before committing, always check that the file does not contain tokens,
machine-local paths, or generated state.

## Stop Managing A File

To stop managing a file while leaving it on disk:

```sh
chezmoi forget ~/.config/some-tool/config.toml
chezmoi cd
git status
git add -A
git commit -m "Stop managing some-tool config"
git push
```

If you want to remove the file from both source state and the target location,
use `chezmoi remove`. For public dotfiles, `forget` is often the safer first
move; delete the target file manually afterward if needed.

## Local Private Overrides

Zsh supports local hooks that are not tracked by git:

```sh
~/.zshrc.local
~/.zprofile.local
```

Use these for machine-specific aliases, private paths, experimental environment
variables, or anything that should not live in a public repository.

## Security Checklist Before Commit

Before pushing public dotfiles, inspect the staged diff:

```sh
chezmoi cd
git diff --cached
```

Look for:

- tokens, API keys, and auth headers
- emails or hostnames you do not want public
- private work or client paths
- cache, history, session, and generated files
- `node_modules`, plugin checkouts, and vendor directories

If you are unsure, do not add the file. Use a local override instead.
