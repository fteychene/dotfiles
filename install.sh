#!/usr/bin/env bash

stow git
stow tabmo
stow bash
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
stow zsh
stow urxvt

stow vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
