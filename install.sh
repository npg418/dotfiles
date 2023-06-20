#!/bin/env bash

ln -sf ~/dotfiles/.rc ~/.rc

if [[ $SHELL = */zsh ]]; then
    ln -sf ~/dotfiles/zsh/.zshrc ~/
elif [ -e ~/.zshrc ]; then
    rm ~/.zshrc
fi

if [ -x "$(command -v git)" ]; then
    ln -sf ~/dotfiles/git/.gitconfig ~/
elif [ -e ~/.gitconfig ]; then
    rm ~/.gitconfig
fi
