#!/bin/bash

mkdir ~/vimfiles
mkdir ~/vimfiles/autoload
mkdir ~/vimfiles/bundle

# Install Pathogen

curl -LSso ~/vimfiles/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install Plugins

git clone https://github.com/kien/ctrlp.vim.git ~/vimfiles/bundle/ctrlp.vim
git clone https://github.com/Shougo/neocomplete.vim.git ~/vimfiles/bundle/neocomplete.vim
git clone https://github.com/scrooloose/nerdtree.git ~/vimfiles/bundle/nerdtree.vim
git clone https://github.com/scrooloose/syntastic.git ~/vimfiles/bundle/syntastic.vim
git clone https://github.com/tpope/vim-dispatch.git ~/vimfiles/bundle/vim-dispatch.vim
git clone https://github.com/Lokaltog/vim-easymotion.git ~/vimfiles/bundle/vim-easymotion.vim

echo DONE