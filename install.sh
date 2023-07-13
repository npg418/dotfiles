#!/bin/env bash

cd `dirname $0`
dot_dir=$(pwd)

ln -sf $dot_dir/.rc ~
ln -sf $dot_dir/.rc.d ~

if [[ $SHELL = */zsh ]]; then
  ln -sf $dot_dir/.zshrc ~
  ln -sf $dot_dir/.p10k.zsh ~
else
  if [ -e ~/.zshrc ]; then
    rm ~/.zshrc
  fi
  if [ -e ~/.p10k.zsh ]; then
    rm ~/.p10k.zsh
  fi
fi

if [ -x "$(command -v git)" ]; then
  ln -sf $dot_dir/.gitconfig ~
elif [ -e ~/.gitconfig ]; then
  rm ~/.gitconfig
fi

if [ -x "$(command -v nvim)" ]; then
  ln -sf $dot_dir/.config/nvim ~/.config/
  curl -fLo ~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim
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
