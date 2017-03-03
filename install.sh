#!/usr/bin/env bash

stow bash
stow zsh
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

stow vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

stow tmux
stow tmuxinator

stow git
stow urxvt
stow i3

stow custom_bin

# Specifix to work
 stow tabmo
