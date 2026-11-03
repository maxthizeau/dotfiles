# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ─── Oh My Zsh ───────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

# Fallback theme; Powerlevel10k (sourced below) takes over when installed.
ZSH_THEME="robbyrussell"

plugins=(git)

source "$ZSH/oh-my-zsh.sh"

# ─── Prompt: Powerlevel10k ───────────────────────────────────────────────────
[[ -f ~/powerlevel10k/powerlevel10k.zsh-theme ]] && source ~/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ─── Editor ──────────────────────────────────────────────────────────────────
export EDITOR="nvim"
export VISUAL="nvim"

# ─── PATH ────────────────────────────────────────────────────────────────────
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
[[ -d "$HOME/.dotnet" ]] && export PATH="$HOME/.dotnet:$PATH"
[[ -d "$HOME/Library/Python/3.9/bin" ]] && export PATH="$HOME/Library/Python/3.9/bin:$PATH"

# ─── Node (nvm) ──────────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# ─── Docker ──────────────────────────────────────────────────────────────────
# Docker Desktop on macOS exposes its socket in the home directory.
[[ -S "$HOME/.docker/run/docker.sock" ]] && export DOCKER_HOST="unix://$HOME/.docker/run/docker.sock"
alias docker-check='docker info 2>/dev/null && echo "✅ Docker OK" || echo "❌ Docker KO"'

# ─── GitLab Runner ───────────────────────────────────────────────────────────
alias runner-status='gitlab-runner status'
alias runner-logs='tail -f ~/Library/Logs/gitlab-runner-healthcheck.log'
alias runner-restart='gitlab-runner restart'
alias runner-config='vim ~/.gitlab-runner/config.toml'

# ─── Machine-specific overrides (not versioned) ──────────────────────────────
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
