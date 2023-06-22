if [ -x $(command -v exa) ]; then
    alias ls="exa --icons"
fi

alias ll="ls -hl"
alias la="ll -a"

if [ -x $(command -v git) ]; then
    alias g="git"
fi

if [ -x $(command -v nvim) ]; then
    alias v="nvim"
    alias vi="nvim"
    alias vim="nvim"
fi
