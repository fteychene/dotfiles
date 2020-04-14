#!/usr/bin/env bash

set -ue

backup() {
  mv ../.bashrc ../.bashrc.orig
  mv ../.dir_colors ../.dir_colors.orig
  mv ../.Xresources ../.Xresources.orig
  mv ../.config/dunst/dunstrc ../.dunstrc.orig
  mv ../.i3/config ../.i3config.orig
  #mv ../.zshrc ../.zshrc.orig
  mv ../.profile ../.profile.orig
}

restore() {
  mv ../.bashrc.orig ../.bashrc
  mv ../.dir_colors.orig ../.dir_colors
  mv ../.Xresources.orig ../.Xresources
  mv ../.dunstrc.orig ../.config/dunst/dunstrc
  mv ../.i3config.orig ../.i3/config
  #mv ../.zshrc.orig ../.zshrc
  mv ../.profile.orig ../.profile
}

trap "restore" ERR

#backup
stow bash
if [ ! -d "../.oh-my-zsh" ]; then
  curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi
stow zsh

stow vim
if [ ! -d "../.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

stow profile

stow tmux
#stow tmuxinator

stow git
stow urxvt
stow i3

stow custom_bin

