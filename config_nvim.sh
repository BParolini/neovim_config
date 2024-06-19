#!/usr/bin/env sh

# author: Bruno Parolini brunoparolini@gmail.com
# description: Installs Neovim configuration dependencies

stow -d "$(dirname "$(realpath "$0")")" -t "$HOME" --dotfiles .
