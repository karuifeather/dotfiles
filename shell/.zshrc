[ -f "$HOME/.profile" ] && . "$HOME/.profile"
export EDITOR="nvim"
alias ll='ls -alF'
alias gs='git status'

eval "$(starship init zsh)"
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

autoload -Uz compinit
compinit
source <(kubectl completion zsh)
#complete -o nospace -C /usr/bin/terraform terraform

. "$HOME/.local/share/../bin/env"
. "/home/ash/.deno/env"

alias code='tmux new -A -s code'
alias dev='tmux new -A -s dev'
alias cls='clear'

alias md='glow -p'

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

alias k='kubectl'
alias kg='kubectl get'
alias kn='kubectl config set-context --current --namespace'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgn='kubectl get nodes'
alias kd='kubectl describe'
alias kaf='kubectl apply -f'
alias kdel='kubectl delete'
alias ll='ls -lah'

alias d='docker'
alias de='docker exec'

export do='--dry-run=client -o yaml'
export now='--force --grace-period=0'
