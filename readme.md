# Dotfiles

My personal configuration files for **Zsh**, **Neovim**, **VS Code**, **WezTerm**, and **Git**.  
All configs are managed using [GNU Stow](https://www.gnu.org/software/stow/) to keep everything organized and easy to apply on any machine.

---

## Structure
```
dotfiles/
├── shell/.zshrc
├── nvim/.config/nvim/init.lua
├── vscode/.config/Code/User/settings.json
├── wezterm/.config/wezterm/wezterm.lua
└── git/.gitignore_global
```

Each folder mirrors where the file should live under $HOME.  
For example:
```
- shell/.zshrc → ~/.zshrc
- nvim/.config/nvim/init.lua → ~/.config/nvim/init.lua
```
---

## Requirements

- Git  
- GNU Stow  
- Zsh

### Installation
```
sudo dnf install -y git stow zsh
```

## Setup

Clone this repo into your home directory:

```
git clone git@github.com:karuifeather/dotfiles.git ~/dotfiles
cd ~/dotfiles
```
Use **Stow** to create symlinks:

```
stow shell nvim vscode wezterm git
```

This links the files into ~ and ~/.config automatically.

If you already have config files, back them up or adopt them:

```
stow --adopt shell nvim vscode wezterm git
git add -A
git commit -m "Adopt existing local configs"
```
---

##  Usage

Edit configs inside ~/dotfiles.  
Because they’re symlinked, changes apply instantly.

```
nvim ~/dotfiles/nvim/.config/nvim/init.lua
git -C ~/dotfiles add -A
git -C ~/dotfiles commit -m "Update Neovim config"
```
---

## New Machine Setup

```
sudo dnf install -y stow git zsh     
git clone git@github.com:karuifeather/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow shell nvim vscode wezterm git
chsh -s "$(command -v zsh)"
exec zsh
```
---

Keep configs in the repo → symlink with Stow → version control with Git.  
Simple and clean.
