#!/usr/bin/env bash

echo "Starting install process..."

cd `dirname $0`
dot_dir=$(pwd)

if ! [ -x "$(command -v nix)" ]; then
  echo "Nix not found! Installing..."
  sh <(curl -L https://nixos.org/nix/install) --no-daemon
  echo "Please re-start your shell to ensure updated PATH applied."
  exit 0
fi

if ! [ -x "$(command -v home-manager)" ]; then
  echo "home-manager not found! Installing..."
  nix-channel --add "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz" home-manager
  nix-channel --update
  NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH} nix-shell "<home-manager>" -A install
  echo "Please re-start your shell to ensure updated PATH applied."
  exit 0
fi

echo "Copying home-manager configuration..."
ln -sf $dot_dir/.config/home-manager ~/.config/home-manager

echo "Syncing home-manager settings..."
home-manager switch

echo "Done!"
