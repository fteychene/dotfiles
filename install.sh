#!/usr/bin/env bash

stow git
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
stow tabmo
stow bash
stow zsh

stow vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
