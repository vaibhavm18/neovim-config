# ----- Completions path (deno)
if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then
  export FPATH="$HOME/.zsh/completions:$FPATH"
fi

# Terminal
export TERM='xterm-256color'

# Aliases
alias vim="nvim"
alias tmux="tmux -u"
alias pnpx='pnpm dlx'
alias ls='eza'
alias neo='neofetch'
alias postman="$HOME/Postman/app/postman"
alias zen="$HOME/zen/zen-bin"

# NVM
export NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.nvm}"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# pnpm (single, deduped)
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in *":$PNPM_HOME:"*) ;; *) export PATH="$PNPM_HOME:$PATH" ;; esac

# Go (fix GOPATH)
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# Android
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"

# App paths
export PATH="$HOME/app:$HOME/AppImages:$HOME/.local/bin:$PATH"

# Deno env
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"

# Zsh completion system
autoload -Uz compinit
compinit

# Bun completions and bin
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fzf (if installed)
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
source ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

# zoxide
eval "$(zoxide init zsh)"

# Starship prompt
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Editor
export EDITOR="nvim"

# yazi helper
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# ---- History: persistent and searchable
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000

setopt APPEND_HISTORY         # append instead of overwrite
setopt INC_APPEND_HISTORY     # write commands immediately
setopt SHARE_HISTORY          # share across sessions
setopt HIST_IGNORE_ALL_DUPS   # drop older duplicates
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE      # ignore commands starting with space
setopt EXTENDED_HISTORY       # timestamps in history

# plugins
source "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.zsh/plugins/zsh-autopair/autopair.zsh"
source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 

bindkey -e
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
bindkey '^F' forward-char

export MANPAGER='nvim +Man!'
alias man='MANPAGER="nvim +Man!" man'

# opencode
export PATH=/home/vaibhav18/.opencode/bin:$PATH
