alias ll="ls -hl"
alias la="ll -A"

if [ -x $(command -v exa) ]; then
    alias ls="exa --icons"
    alias ll="ls -hlg"
    alias la="ll -a"
fi

if [ -x $(command -v git) ]; then
    alias g="git"
fi

if [ -x $(command -v nvim) ]; then
    alias v="nvim"
    alias vi="nvim"
    alias vim="nvim"
fi
