#!/usr/bin/env bash

stow git
stow tabmo
stow bash
stow zsh

stow vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
