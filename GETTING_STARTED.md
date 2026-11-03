# Getting started

Installer cette configuration sur une nouvelle machine.

- [macOS](#macos)
- [Linux (Ubuntu / Debian)](#linux-ubuntu--debian)
- [Autres distributions Linux](#autres-distributions-linux)
- [Ce que fait `install.sh`](#ce-que-fait-installsh)
- [Après l'installation](#après-linstallation)
- [Dépannage](#dépannage)
- [Désinstaller](#désinstaller)

---

## macOS

### 1. Prérequis

Installer les outils en ligne de commande Xcode (git, make, compilateur C) :

```sh
xcode-select --install
```

### 2. Cloner le dépôt

Le dépôt doit être cloné **directement dans le home** (`~/dotfiles`) :

```sh
git clone https://github.com/maxthizeau/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. Lancer l'installation

```sh
./install.sh
```

Le script installe Homebrew s'il est absent, puis tous les paquets du
[`Brewfile`](Brewfile) : `neovim`, `tmux`, `stow`, `ripgrep`, `fzf`, `tree`,
`trash` (seulement avant macOS 15), iTerm2 et la police Meslo LG Nerd Font.
Il installe ensuite le shell, Node, crée les liens symboliques et prépare
Neovim (détail dans [Ce que fait `install.sh`](#ce-que-fait-installsh)).

Si des fichiers existent déjà (`~/.zshrc`, `~/.tmux.conf`, `~/.config/nvim`,
`~/.p10k.zsh`), ils sont renommés en `*.AAAAMMJJ-HHMMSS.bak` avant d'être
remplacés par des liens vers le dépôt.

### 4. Configurer iTerm2

1. **Police** : _Settings → Profiles → Text → Font_ → `MesloLGM Nerd Font`
   (nécessaire pour les icônes de nvim-tree et du prompt Powerlevel10k).
2. **Couleurs** : _Settings → Profiles → Colors → Color Presets… → Import…_ →
   choisir `~/dotfiles/iterm/coolnight.itermcolors`, puis le sélectionner.
3. Laisser la touche **Option** en mode _Normal_ (les raccourcis `Alt-j` /
   `Alt-k` de Neovim utilisent les caractères produits par Option sur un
   clavier français).

### 5. Ouvrir un nouveau terminal

```sh
exec zsh
```

---

## Linux (Ubuntu / Debian)

Testé sur **Ubuntu 24.04** (arm64 ; le script gère aussi x86_64). Fonctionne de la même façon sur
Debian 12 et dérivés (Linux Mint, Pop!_OS…).

### 1. Prérequis

```sh
sudo apt update && sudo apt install -y git curl
```

### 2. Cloner le dépôt

```sh
git clone https://github.com/maxthizeau/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. Lancer l'installation

```sh
./install.sh
```

Le script demande le mot de passe `sudo` pour les paquets système. Il
installe via `apt` :

| Paquet                        | Utilité                                                          |
| ----------------------------- | ---------------------------------------------------------------- |
| `build-essential`             | `make` + `gcc` : telescope-fzf-native, LuaSnip, parsers Treesitter |
| `luarocks`, `lua5.1`, `liblua5.1-0-dev` | Plugins distribués via luarocks (plenary) — évite que lazy.nvim compile son propre Lua |
| `git`, `curl`, `unzip`, `xz-utils` | Téléchargements (lazy.nvim, Mason, nvm…)                    |
| `zsh`, `tmux`, `stow`         | Shell, multiplexeur, gestion des liens                           |
| `ripgrep`, `fzf`, `tree`      | Recherche (Telescope) et utilitaires                             |
| `trash-cli`                   | Commande `trash` utilisée par nvim-tree pour supprimer           |
| `xclip`, `wl-clipboard`       | Presse-papier système (`"+y`) sous X11 / Wayland                 |
| `fontconfig`                  | Installation de la Nerd Font                                     |

Ensuite :

- **Neovim** : la version d'`apt` est trop ancienne (< 0.11). Le script
  télécharge la dernière release officielle dans `/opt/nvim-linux-<arch>` et
  crée le lien `/usr/local/bin/nvim`. Rien n'est fait si un Neovim ≥ 0.11 est
  déjà présent.
- **Police** : _Meslo LG Nerd Font_ est installée dans
  `~/.local/share/fonts/` (uniquement si `fc-cache` est disponible, donc pas
  sur un serveur).
- **Shell par défaut** : `chsh` passe le shell à zsh.

### 4. Configurer le terminal

Dans GNOME Terminal (ou l'émulateur utilisé) : _Préférences → Profil →
Police personnalisée_ → `MesloLGM Nerd Font`.

Le thème `coolnight` est spécifique à iTerm2 ; sous Linux, choisir un thème
sombre équivalent dans le terminal (tokyonight est disponible pour la plupart
des émulateurs).

### 5. Recharger la session

Se **déconnecter / reconnecter** pour que le changement de shell par défaut
soit pris en compte, ou lancer `exec zsh` dans le terminal courant.

### Sur un serveur (sans interface graphique, via SSH)

Même procédure. La police n'est pas installée côté serveur : c'est le
terminal **local** qui doit utiliser une Nerd Font. Pour ne réinstaller que la
config (sans `apt`), par exemple sans droits `sudo` :

```sh
./install.sh --skip-packages
```

---

## Autres distributions Linux

Seul `apt` est automatisé. Sur une autre distribution, installer les
équivalents puis lancer `./install.sh --skip-packages` :

```sh
# Fedora
sudo dnf install -y git curl unzip xz gcc make compat-lua compat-lua-devel luarocks zsh tmux stow ripgrep fzf tree trash-cli xclip wl-clipboard neovim

# Arch Linux
sudo pacman -S --needed git curl unzip xz base-devel lua51 luarocks zsh tmux stow ripgrep fzf tree trash-cli xclip wl-clipboard neovim ttf-meslo-nerd
```

Vérifier que `nvim --version` affiche au moins **0.11**.

---

## Ce que fait `install.sh`

Toutes les étapes sont **idempotentes** : relancer le script ne casse rien et
ne réinstalle pas ce qui est déjà présent.

1. **Paquets système** — Homebrew + `Brewfile` (macOS) ou `apt` + Neovim +
   Nerd Font (Linux). Ignoré avec `--skip-packages`.
2. **Shell** — Oh My Zsh (sans écraser le `.zshrc`), Powerlevel10k dans
   `~/powerlevel10k`, zsh comme shell par défaut.
3. **Node** — nvm puis Node LTS (requis par Mason pour `ts_ls`, `eslint`,
   `cssls`, `prettier`), et la CLI `tree-sitter` (requise par
   nvim-treesitter pour compiler les parsers).
4. **Liens symboliques** — sauvegarde des fichiers existants puis
   `stow --restow nvim tmux zsh`.
5. **Plugins tmux** — clone de tpm et installation des plugins.
6. **Neovim** — `:Lazy! restore` (plugins aux versions de `lazy-lock.json`)
   puis `:MasonInstall` des serveurs LSP et formateurs. Ignoré avec
   `--skip-nvim`.

```sh
./install.sh --help
```

---

## Après l'installation

Vérifier que tout est en place :

```sh
nvim --version | head -1   # NVIM v0.11.x ou plus
tmux -V
echo $SHELL                # .../zsh
ls -l ~/.zshrc ~/.tmux.conf ~/.config/nvim   # liens vers ~/dotfiles
```

Dans Neovim :

- `:checkhealth` — diagnostic général ;
- `:Lazy` — état des plugins ;
- `:Mason` — serveurs LSP et formateurs installés.

Dans tmux : `Ctrl-a` puis `I` si les plugins ne sont pas chargés.

Pour le prompt : `p10k configure` permet de le reconfigurer (le résultat est
écrit dans `~/.p10k.zsh`, donc dans le dépôt).

### Réglages propres à la machine

Tout ce qui ne doit pas être versionné (tokens, chemins spécifiques, alias
pro…) va dans `~/.zshrc.local`, chargé à la fin du `.zshrc`.

---

## Dépannage

| Problème                                                   | Solution                                                                                   |
| ---------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| Icônes affichées comme des carrés ou `?`                   | Le terminal n'utilise pas une Nerd Font (voir l'étape « Configurer le terminal »).          |
| `stow` signale un conflit (`existing target is neither a link nor a directory`) | Déplacer le fichier indiqué, puis relancer `./install.sh --skip-packages`. |
| Un serveur LSP ne démarre pas                              | `:Mason` pour l'installer, `:LspInfo` / `:checkhealth vim.lsp` pour diagnostiquer.          |
| `Too many rounds of missing plugins` au démarrage de Neovim | Un plugin luarocks (plenary) n'a pas pu se compiler : vérifier `luarocks --version`, puis `:Lazy build plenary`. |
| Erreur de compilation Treesitter                           | Vérifier `gcc --version` et `tree-sitter --version`, puis `:TSUpdate`.                      |
| `"+y` ne copie pas dans le presse-papier (Linux)           | Vérifier que `xclip` (X11) ou `wl-clipboard` (Wayland) est installé.                        |
| Le shell reste bash après installation (Linux)             | Se déconnecter/reconnecter, ou `chsh -s "$(command -v zsh)"`.                               |
| `nvm: command not found`                                   | Ouvrir un nouveau terminal ; nvm est chargé par le `.zshrc`.                                |

---

## Désinstaller

Supprimer les liens symboliques (les fichiers du dépôt ne sont pas touchés) :

```sh
cd ~/dotfiles
stow --delete --target "$HOME" nvim tmux zsh
```

Les éventuelles sauvegardes `*.bak` créées à l'installation peuvent ensuite
être restaurées à la main.
