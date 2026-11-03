# dotfiles

Ma configuration de développement : **Neovim**, **tmux** et **zsh**, gérée avec
[GNU Stow](https://www.gnu.org/software/stow/) et installable en une commande
sur macOS ou Ubuntu/Debian.

> Pour installer la config sur une nouvelle machine, voir
> **[GETTING_STARTED.md](GETTING_STARTED.md)**.

## Contenu du dépôt

```
dotfiles/
├── install.sh              # Installation complète (macOS + Debian/Ubuntu), idempotente
├── Brewfile                # Paquets Homebrew installés sur macOS
├── nvim/                   # Paquet stow → ~/.config/nvim
│   └── .config/nvim/
│       ├── init.lua        # Point d'entrée : require("v2")
│       ├── lazy-lock.json  # Versions figées des plugins
│       ├── stylua.toml     # Style du formatage Lua
│       └── lua/v2/
│           ├── config/     # Options, keymaps, autocmds, bootstrap lazy.nvim
│           └── plugins/    # Un fichier par plugin (ou groupe de plugins)
├── tmux/                   # Paquet stow → ~/.tmux.conf
├── zsh/                    # Paquet stow → ~/.zshrc et ~/.p10k.zsh
└── iterm/
    └── coolnight.itermcolors  # Thème de couleurs iTerm2 (import manuel)
```

Chaque dossier de premier niveau (`nvim`, `tmux`, `zsh`) est un **paquet
Stow** : son contenu reproduit l'arborescence du `$HOME`. `stow nvim` crée donc
le lien `~/.config/nvim → dotfiles/nvim/.config/nvim`. Les fichiers restent
dans le dépôt, toute modification est directement versionnée.

## Neovim

Configuration écrite « à la main » (sans distribution type LazyVim), basée sur
[lazy.nvim](https://github.com/folke/lazy.nvim). Requiert **Neovim ≥ 0.11**.

- `lua/v2/config/options.lua` — options (leader = `Espace`, local leader = `,`,
  numéros relatifs, indentation 4 espaces, pas de swap, undo persistant dans
  `~/.vim/undodir`, colonne repère à 80).
- `lua/v2/config/keymaps.lua` — raccourcis généraux.
- `lua/v2/config/init.lua` — autocmds (surlignage du yank, suppression des
  espaces en fin de ligne à l'enregistrement, keymaps LSP).
- `lua/v2/config/lazy_init.lua` — installation automatique de lazy.nvim et
  chargement de `lua/v2/plugins/`.

### Plugins

| Domaine            | Plugins                                                                                   |
| ------------------ | ----------------------------------------------------------------------------------------- |
| Thème / UI         | tokyonight (storm), lualine, noice, fidget, which-key, snacks                             |
| Navigation         | telescope (+ fzf-native), nvim-tree, harpoon 2, vim-tmux-navigator, vim-maximizer         |
| LSP / complétion   | nvim-lspconfig, mason + mason-lspconfig, nvim-cmp, LuaSnip + friendly-snippets            |
| Formatage / lint   | conform (prettier, stylua — format à l'enregistrement), nvim-lint (stylelint)             |
| Syntaxe            | nvim-treesitter (+ textobjects), Comment.nvim + ts-context-commentstring, nvim-autopairs   |
| Git                | vim-fugitive, diffview                                                                    |
| Divers             | trouble, undotree, cloak (masque les valeurs des `.env`), vim-abolish, editorconfig       |

Serveurs LSP installés automatiquement par Mason : `lua_ls`, `ts_ls`, `eslint`,
`cssls`, `rust_analyzer`.

### Raccourcis principaux

`<leader>` = `Espace`.

| Raccourci                     | Action                                                     |
| ----------------------------- | ---------------------------------------------------------- |
| `<leader>sf` / `<leader>sg`   | Rechercher un fichier / grep dans le projet                |
| `<leader>sG`                  | Grep depuis la racine git                                  |
| `<leader><space>`             | Liste des buffers ouverts                                  |
| `<leader>?` / `<leader>/`     | Fichiers récents / recherche floue dans le buffer          |
| `<leader>sw` / `<leader>sr`   | Rechercher le mot sous le curseur / reprendre la recherche |
| `<leader>pv` / `<leader>pc`   | Focus / afficher-masquer l'explorateur (nvim-tree)         |
| `<leader>pf`                  | Révéler le fichier courant dans l'explorateur              |
| `d` / `O` (dans nvim-tree)    | Mettre à la corbeille / ouvrir dans le Finder              |
| `<leader>H` / `<leader>h`     | Ajouter à Harpoon / menu Harpoon                           |
| `<leader>1` … `<leader>5`     | Aller au fichier Harpoon n°1 à 5                           |
| `gd` `gr` `gI` `gy`           | Définition / références / implémentations / type           |
| `K` / `gK`                    | Documentation / signature                                  |
| `<leader>ca` / `<leader>cr`   | Code action / renommer                                     |
| `[d` `]d`, `[e` `]e`          | Diagnostic précédent/suivant, erreur précédente/suivante   |
| `<leader>cO` / `<leader>cM`   | (TS) Organiser les imports / ajouter les imports manquants |
| `<leader>gs`                  | Statut git (fugitive)                                      |
| `<leader>gd` / `<leader>gx`   | Ouvrir / fermer diffview                                   |
| `<leader>tt`                  | Ouvrir Trouble                                             |
| `<leader>u`                   | Undotree                                                   |
| `<leader>sm`                  | Maximiser / restaurer un split                             |
| `<leader>rw`                  | Rechercher/remplacer le mot sous le curseur                |
| `<leader>y` / `<leader>p`     | Copier vers le presse-papier système / coller sans écraser |
| `Ctrl-s`                      | Enregistrer                                                |
| `Ctrl-h/j/k/l`                | Naviguer entre splits Neovim **et** panneaux tmux          |

> Les déplacements de sélection `Alt-j` / `Alt-k` sont mappés sur les
> caractères `È` / `Ï` produits par la touche Option d'un clavier Mac français.

### Mettre à jour les plugins

`:Lazy update` met à jour les plugins et `lazy-lock.json` ; commiter ensuite
le fichier de lock. `:Lazy restore` revient aux versions du lock.

## tmux

- Préfixe : `Ctrl-a` (au lieu de `Ctrl-b`).
- `prefix |` / `prefix -` : split vertical / horizontal.
- `prefix h/j/k/l` : redimensionner, `prefix m` : zoom sur le panneau.
- `prefix r` : recharger la config.
- Souris activée, mode copie vi (`v` pour sélectionner, `y` pour copier).
- Plugins (via [tpm](https://github.com/tmux-plugins/tpm)) : vim-tmux-navigator,
  tmux-themepack (`powerline/default/cyan`), tmux-resurrect et tmux-continuum
  (sessions sauvegardées toutes les 15 min et restaurées au démarrage).
- `prefix I` : installer les plugins, `prefix U` : les mettre à jour.

## zsh

- [Oh My Zsh](https://ohmyz.sh/) avec le plugin `git`.
- Prompt [Powerlevel10k](https://github.com/romkatv/powerlevel10k), configuré
  par `zsh/.p10k.zsh` (`p10k configure` pour le regénérer).
- Node via [nvm](https://github.com/nvm-sh/nvm).
- `EDITOR=nvim`, alias Docker et GitLab Runner.
- Les réglages propres à une machine (tokens, chemins locaux…) vont dans
  `~/.zshrc.local`, chargé automatiquement s'il existe et **non versionné**.
