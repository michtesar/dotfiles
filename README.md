# dotfiles

Osobni macOS dotfiles spravovane pres [chezmoi](https://www.chezmoi.io/).

Repo je zamerne public. Patri sem konfigurace, ne citliva data: zadne tokeny,
zadny `gh` auth, zadny opencode config, zadna historie shellu a zadny runtime
stav aplikaci.

## Rychly Start Na Novem Macu

Na cistem macOS spust:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/michtesar/dotfiles/main/install.sh)"
```

Bootstrap udela:

1. overi Xcode Command Line Tools
2. nainstaluje Homebrew, pokud chybi
3. nainstaluje chezmoi, pokud chybi
4. aplikuje toto repo pres `chezmoi`
5. spusti Homebrew bundle pro core + GUI aplikace
6. nainstaluje Oh My Zsh, tmux pluginy a VS Code extensions
7. aplikuje male macOS defaults

Mac App Store aplikace se nespousti automaticky, protoze `mas` je obcas
nespolehlive i pri prihlasenem App Store uctu.

## Mentalni Model Chezmoi

Chezmoi ma dve dulezita mista:

```text
target files     skutecne soubory, ktere aplikace pouzivaji
source state     git repo, ze ktereho chezmoi target files generuje
```

Priklady target files:

```text
~/.zshrc
~/.config/tmux/tmux.conf
~/.config/nvim/init.lua
~/Library/Application Support/Code/User/settings.json
```

Source state je lokalni checkout tohoto repa. Cestu zjistis:

```sh
chezmoi source-path
```

Chezmoi source typicky lezi tady:

```text
~/.local/share/chezmoi
```

V source repu maji soubory specialni jmena:

```text
dot_zshrc                         -> ~/.zshrc
dot_config/tmux/tmux.conf         -> ~/.config/tmux/tmux.conf
dot_local/bin/executable_foo      -> ~/.local/bin/foo
private_Library/...               -> ~/Library/... s privatnejsimi permissions
```

Jinymi slovy: aplikace ctou normalni soubory v home adresari, ale pravda pro git
zije v chezmoi source.

## Co Je Spravovane

- Homebrew manifesty v `~/.config/homebrew`
- Zsh: `~/.zshrc`, `~/.zprofile`
- Neovim: `~/.config/nvim`
- tmux: `~/.config/tmux`
- btop: `~/.config/btop`
- Ghostty: `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`
- DOSBox Staging: `~/Library/Preferences/DOSBox/dosbox-staging.conf`
- VS Code user settings, keybindings a seznam extensions
- male macOS defaults

## Co Neni Spravovane

- `~/.config/gh`
- opencode config
- SSH klice a secrets
- shell historie
- app cache, sessions, workspace state a generated files
- tmux plugin checkouty
- VS Code `globalStorage`, `workspaceStorage` a `History`

## Homebrew

Homebrew manifesty jsou v:

```text
~/.config/homebrew/Brewfile      core CLI/dev tools
~/.config/homebrew/Brewfile.gui  GUI apps and fonts
~/.config/homebrew/Brewfile.mas  Mac App Store apps
```

Nainstaluj defaultni baliky:

```sh
dotfiles-brew
```

Nainstaluj Mac App Store baliky explicitne:

```sh
dotfiles-brew --mas
```

Kdyz `mas` failne, nejdriv otevri App Store, prihlas se, otevri Purchased nebo
stranku dane aplikace, a pak zkus MAS command znovu.

## VS Code

Nainstaluj extensions ze seznamu:

```sh
dotfiles-vscode-extensions
```

Aktualizuj seznam extensions podle aktualniho VS Code:

```sh
code --list-extensions | sort > "$(chezmoi source-path)/vscode/extensions.txt"
```

Pak zmenu commitni ze source repa:

```sh
chezmoi cd
git status
git add vscode/extensions.txt
git commit -m "Update VS Code extensions"
git push
```

## macOS Defaults

Aplikuj osobni macOS preference:

```sh
dotfiles-macos-defaults
```

Aktualne to nastavuje tap-to-click, vypina automaticke opravy textu, vypina
tecku po dvojite mezere a nastavuje aktualni US/Czech input sources.

Nektere macOS zmeny se projevi az po logout/login.

## tmux Pluginy

Plugin checkouty se necommituji. V repu je jen `tmux.conf`, kde jsou pluginy
deklarovane.

TPM a pluginy nainstaluj:

```sh
dotfiles-tmux-plugins
```

V bezicim tmuxu muzes taky pouzit standardni TPM flow:

```text
prefix + I    install plugins
prefix + U    update plugins
prefix + alt+u clean plugins
```

Prefix je v tomto configu `Ctrl-a`.

## Kazdodenni Chezmoi Workflow

Podivej se, co chezmoi spravuje a co by aplikoval:

```sh
chezmoi managed
chezmoi diff
```

Aplikuj source state do home adresare:

```sh
chezmoi apply
```

Stahni posledni zmeny z GitHubu a aplikuj je:

```sh
chezmoi update
```

Otevri source repo:

```sh
chezmoi cd
```

## Jak Commitnout Zmenu, Kterou Jsi Udelal V Target Souboru

Tohle je nejcastejsi situace: upravis normalni config tam, kde ho aplikace
opravdu pouziva, treba `~/.config/tmux/tmux.conf`. Chezmoi o te zmene vi, ale
git repo se samo nezmeni. Musis ji prenest do source state.

### Priklad: Upravil Jsem tmux Config

1. Zkontroluj rozdil mezi target souborem a source state:

```sh
chezmoi diff ~/.config/tmux/tmux.conf
```

2. Pokud zmena vypada spravne, pridej aktualni target soubor do chezmoi source:

```sh
chezmoi add ~/.config/tmux/tmux.conf
```

3. Prejdi do source repa:

```sh
chezmoi cd
```

4. Zkontroluj git diff:

```sh
git status
git diff -- dot_config/tmux/tmux.conf
```

5. Commitni a pushni:

```sh
git add dot_config/tmux/tmux.conf
git commit -m "Update tmux config"
git push
```

To je cely tok:

```text
upravim ~/.config/tmux/tmux.conf
chezmoi diff ~/.config/tmux/tmux.conf
chezmoi add ~/.config/tmux/tmux.conf
chezmoi cd
git diff
git add .
git commit
git push
```

## Jak Editovat Pres Chezmoi Rovnou

Alternativa je editovat managed soubor pres chezmoi:

```sh
chezmoi edit ~/.config/tmux/tmux.conf
chezmoi apply
```

`chezmoi edit` otevira source soubor. `chezmoi apply` ho pak zapise do target
lokace.

Tenhle styl je cisty, kdyz vis, ze menis dotfiles. Prime flow pro bezne pouziti
je ale klidne: upravit realny config, `chezmoi add`, commit.

## Pridani Noveho Souboru

Kdyz chces spravovat novy config:

```sh
chezmoi add ~/.config/some-tool/config.toml
chezmoi cd
git status
git add .
git commit -m "Add some-tool config"
git push
```

Pred commitem vzdy zkontroluj, ze v souboru nejsou tokeny nebo machine-local
hodnoty.

## Odebrani Spravovaneho Souboru

Kdyz uz soubor nechces spravovat, ale chces ho nechat na disku:

```sh
chezmoi forget ~/.config/some-tool/config.toml
chezmoi cd
git status
git add -A
git commit -m "Stop managing some-tool config"
git push
```

Kdyz chces soubor odstranit ze source state i z target lokace, pouzij
`chezmoi remove`. U public dotfiles je ale casto bezpecnejsi nejdriv pouzit
`forget` a target soubor pripadne smazat rucne.

## Lokalne Soukrome Veci

Zsh podporuje local hooky, ktere nejsou v gitu:

```sh
~/.zshrc.local
~/.zprofile.local
```

Sem patri machine-specific aliasy, privatni cesty, experimentalni env vars nebo
cokoliv, co nechces v public repu.

## Bezpecnostni Checklist Pred Commitem

Pred pushem public dotfiles projdi:

```sh
chezmoi cd
git diff --cached
```

Hledej hlavne:

- tokeny, API keys, auth headery
- emaily nebo hostnames, ktere nechces verejne
- private cesty k praci nebo klientum
- cache, history, session a generated soubory
- `node_modules`, plugin checkouty a vendor adresare

Kdyz si nejsi jisty, soubor radsi nepridavej a pouzij local override.
