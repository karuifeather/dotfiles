[ -f "$HOME/.profile" ] && . "$HOME/.profile"
export EDITOR="nvim"
alias ll='ls -alF'
alias gs='git status'
# Starship prompt if installed
if command -v starship >/dev/null 2>&1; then eval "$(starship init zsh)"; fi
