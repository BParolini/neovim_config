#!/usr/bin/env sh

# author: Bruno Parolini brunoparolini@gmail.com
# description: Installs Neovim configuration dependencies

BASEDIR="$(dirname "$(realpath "$0")")"

rm -rf "$HOME/.config/nvim"
ln -sfF "$BASEDIR/config" "$HOME/.config/nvim"
