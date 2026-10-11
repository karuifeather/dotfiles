# Dotfiles

Personal configuration for Zsh, Neovim, VS Code, WezTerm, Git, Starship, and tmux. The repository follows the target layout expected by [GNU Stow](https://www.gnu.org/software/stow/), so changes made in `~/dotfiles` are available through symlinks in `$HOME`.

## Repository layout

```text
shell/.zshrc                         ~/.zshrc
nvim/.config/nvim/init.lua           ~/.config/nvim/init.lua
vscode/.config/Code/User/settings.json
                                      ~/.config/Code/User/settings.json
wezterm/.config/wezterm/wezterm.lua  ~/.config/wezterm/wezterm.lua
tmux/.config/tmux/tmux.conf          ~/.config/tmux/tmux.conf
starship/.config/starship.toml       ~/.config/starship.toml
git/.gitignore_global                ~/.gitignore_global
```

## Install and apply

On Nobara/Fedora:

```bash
sudo dnf install -y git stow zsh
git clone https://github.com/karuifeather/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

VS Code should keep its application-data directory as a real directory. Create the User directory before stowing so Stow links only the tracked files instead of symlinking the whole `Code` directory:

```bash
mkdir -p ~/.config/Code/User
stow shell nvim vscode wezterm tmux starship git
chsh -s "$(command -v zsh)"
```

If a target file already exists, back it up first. `stow --adopt` is available when intentionally importing an existing file into the repository, but review the resulting diff before committing.

Check the planned links without changing anything:

```bash
stow --no --verbose shell nvim vscode wezterm tmux starship git
```

## Neovim and Kubernetes YAML

Neovim uses nvim-cmp with LSP, path, and buffer completion. LuaSnip remains available for expanding snippets returned by language servers, while standalone LuaSnip completion entries stay out of the completion menu. Enter only confirms an explicitly selected item; Tab and Shift-Tab continue to navigate completion items and snippet placeholders.

The Mason/LSP setup keeps `pyright` and adds `yamlls`. Treesitter includes YAML, and SchemaStore plus a scoped Kubernetes schema provide validation, key completion, diagnostics, and hover information for common resources such as Pods, Deployments, Services, ConfigMaps, and Secrets. Generic YAML files continue to use the YAML language server and matching SchemaStore entries.

After changing the Neovim configuration, restart Neovim or run `:source ~/.config/nvim/init.lua`. If a new plugin or Mason server was added, run `:Lazy sync` and install/update `yamlls` from `:Mason`. Reload tmux with `Ctrl-b r`; reload WezTerm with `Ctrl-Shift-R`.

## Custom tmux shortcuts

| Keys | Action |
| --- | --- |
| `Alt-h/j/k/l` | Move left/down/up/right between panes |
| `Ctrl-h/j/k/l` | Move between tmux panes and Neovim windows seamlessly |
| `Ctrl-b v` | Split left/right |
| `Ctrl-b s` | Split top/bottom |
| `Ctrl-b H/J/K/L` | Resize the current pane |
| `Alt-u/i` | Previous/next window |
| `Ctrl-b r` | Reload `tmux.conf` |

The Ctrl navigation uses `christoomey/vim-tmux-navigator`; the existing Alt navigation and prefix shortcuts remain available. WezTerm does not bind these Ctrl/Alt navigation keys, so it passes them through to tmux and Neovim.

## Safe workflow

Edit files in `~/dotfiles`, inspect the diff, and validate before committing:

```bash
git -C ~/dotfiles diff --check
git -C ~/dotfiles diff --stat
git -C ~/dotfiles status --short
```

Do not commit or push automatically from setup scripts. Keep generated caches, cookies, history, local storage, and runtime data outside the tracked VS Code User configuration.
