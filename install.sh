#!/bin/env bash

cd `dirname $0`
dot_dir=$(pwd)

ln -sf $dot_dir/.rc ~
ln -sf $dot_dir/.rc.d ~

if [[ $SHELL = */zsh ]]; then
  ln -sf $dot_dir/.zshrc ~
else
  if [ -e ~/.zshrc ]; then
    rm ~/.zshrc
  fi
fi

if [ -x "$(command -v git)" ]; then
  ln -sf $dot_dir/.gitconfig ~
elif [ -e ~/.gitconfig ]; then
  rm ~/.gitconfig
fi

if [ -x "$(command -v nvim)" ]; then
  ln -sf $dot_dir/.config/nvim ~/.config/
elif [ -e ~/.config/nvim ]; then
  rm ~/.config/nvim
fi

if ! [ -x "$(command -v deno)" ]; then
  curl -fsSL https://deno.land/x/install/install.sh | sh
fi

ln -sf $dot_dir/.config/locale.conf ~/.config/

if [ -x "$(command -v tmux)" ]; then
  ln -sf $dot_dir/.tmux.conf ~
fi

if [ -x "$(command -v oh-my-posh)" ]; then
  themes=~/.local/share/oh-my-posh/themes
  mkdir -p $themes
  ln -sf $dot_dir/npg418.omp.json $themes
fi

