plugins=(
  git 
  zsh-z
  zsh-autosuggestions
)
#----- plugins setting -----
# auto suggest
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#009600"
source $ZSH/oh-my-zsh.sh

# VS Code
function vs() {
    [ $# -eq 0 ] && code ./ || code "$@"
}

# Cursor
function cr() {
    [ $# -eq 0 ] && cursor ./ || cursor "$@"
}

# Antigravity
function ag() {
    [ $# -eq 0 ] && agy ./ || agy "$@"
}


# Example aliases
alias c="clear"
alias ipconfig="ifconfig en0"
alias szsh="source ~/.zshrc"
alias fuckAudio="sudo killall coreaudiod"

# node 
alias pi="pnpm install"
alias pb="pnpm build"
alias pd="pnpm dev"
alias pu="pnpm update -i"
alias yd="yarn dev"
alias md="make d"

# agent 
alias gay="gemini"
alias cc="claude --permission-mode bypassPermissions"
alias cx="codex -s danger-full-access -a never" 

# github cli 
alias gas="gh auth switch"