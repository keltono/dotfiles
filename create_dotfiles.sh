#!/bin/bash
#put all of these files in the correct place after a clone
#TODO create a script that installs all of the nix stuff

ln .vimrc ~/.vimrc
mkdir -p ~/.config/nvim
ln .vimrc ~/.config/nvim/init.vim
ln .bashrc ~/.bashrc
ln .bash_aliases ~/.bash_aliases
#mkdir -p ~/.i3/
#ln i3config ~/.i3/config
#ln .i3status.conf ~/.i3status.conf
#ln .XCompose ~/.XCompose
#mkdir -p ~/.config/nixpkgs/
#ln home.nix ~/.config/nixpkgs/home.nix
