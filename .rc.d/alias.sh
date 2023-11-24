alias ll="ls -hl"
alias la="ll -A"

if [ -x $(command -v eza) ]; then
    alias ls="eza --icons"
    alias ll="ls -hlg"
    alias la="ll -a"
fi

if [ -x $(command -v git) ]; then
    alias g="git"
    alias cdgr='cd "$(git rev-parse --show-toplevel)"'
fi

if [ -x $(command -v nvim) ]; then
    alias v="nvim"
    alias vi="nvim"
    alias vim="nvim"
fi
