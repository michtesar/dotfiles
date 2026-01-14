# Chezmoi Dotfiles

A brief overview of the dotfiles repository of configuration of my personal computer.

Made with ❤️ by [Michael Tesar](https://github.com/michtesar) in January 2026.

## Quick Documentation

### What is this?

chezmoi manages dotfiles by keeping a source-of-truth repo and applying it safely to any machine.
Files prefixed with dot_ become dotfiles, private_ are mode 0600.
	•	Official package & docs: https://www.chezmoi.io/
	•	GitHub repo: https://github.com/twpayne/chezmoi

## Installation

### Install prerequisites (macOS)

```bash
brew install chezmoi git
```
### Initialize

Initialize on a new computer (via SSH)
	1.	Make sure SSH connection works
	2.	Initialize and apply

```bash
chezmoi init git@github.com:<your-username>/dotfiles.git
chezmoi apply
```

That’s it. No cloning, no symlinks, no drama.

## Daily Workflow

### Edit a file

Always edit via chezmoi:

```bash
chezmoi edit ~/.zshrc
```

### Add a new file

```bash
chezmoi add ~/.gitconfig
```

### Remove a file

```bash
chezmoi remove ~/.somefile
```

### See pending changes

```bash
chezmoi diff
```

### Apply changes

```bash
chezmoi apply
```

### Sync (commit + push)

```bash
chezmoi cd
git status
git commit -am "Update dotfiles"
git push
```

### Pull updates on another machine

```bash
chezmoi update
```

## Repository Structure

```
.
├── dot_config
│   └── zed
│       └── private_settings.json
├── dot_zshrc
└── private_Library
    └── private_Application Support
        ├── com.mitchellh.ghostty
        │   └── config
        └── private_Cursor
            └── User
```

## Additional software
Here is a list of software that is being used by various configurations.

### Software install (Homebrew)

```bash
brew install --cask \
  ghostty \
  cursor \
  zed \
  font-jetbrains-mono
```

### Zsh & Oh-My-Zsh

Install Oh-My-Zsh
	•	[https://ohmyz.sh/](https://ohmyz.sh/)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Zsh plugins

```bash
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
```

Install them:

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Links:
	•	[Git plugin (built-in)](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)
	•	[Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
	•	[Syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
