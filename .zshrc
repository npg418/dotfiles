source ~/.rc
bindkey -v

export EDITOR=nvim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

setopt share_history
setopt incappendhistory
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

bindkey -r '^j'

eval "$(oh-my-posh init zsh --config ~/.local/share/oh-my-posh/themes/npg418.omp.json)"
