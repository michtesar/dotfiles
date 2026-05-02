#!/usr/bin/env bash
set -euo pipefail

repo_url="https://github.com/michtesar/dotfiles.git"

info() {
  printf '\n==> %s\n' "$*"
}

if ! xcode-select -p >/dev/null 2>&1; then
  info "Installing Xcode Command Line Tools"
  xcode-select --install || true
  printf 'Finish the Xcode Command Line Tools installer, then rerun this script.\n'
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if ! command -v chezmoi >/dev/null 2>&1; then
  info "Installing chezmoi"
  brew install chezmoi
fi

info "Applying dotfiles"
if chezmoi source-path >/dev/null 2>&1 && [ -d "$(chezmoi source-path)/.git" ]; then
  chezmoi update --apply
else
  chezmoi init --apply "$repo_url"
fi

info "Installing Oh My Zsh"
"$HOME/.local/bin/dotfiles-oh-my-zsh" || true

info "Installing Homebrew bundles"
"$HOME/.local/bin/dotfiles-brew"

info "Installing tmux plugins"
"$HOME/.local/bin/dotfiles-tmux-plugins" || true

info "Installing VS Code extensions"
"$HOME/.local/bin/dotfiles-vscode-extensions" || true

info "Applying macOS defaults"
"$HOME/.local/bin/dotfiles-macos-defaults" || true

info "Done"
