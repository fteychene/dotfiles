#!/bin/bash

stow -t $HOME tabmo
stow -t $HOME bash
stow -t $HOME zsh

stow -t $HOME vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
