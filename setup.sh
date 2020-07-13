#!/bin/bash

# MAKE SURE TO RUN apt.sh first

######################## Zsh Setup ########################
# Setup zsh as default
chsh -s $(which zsh)
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# Custom plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# Symlink .zshrc
local dotfiles_dir=$(dirname $0)
mv "$HOME/.zshrc" "$HOME/.zshrc_system"
ln -s "$dotfiles_dir/.zshrc" "$HOME/.zshrc"
ln -s "$dotfiles_dir/.p10k.zsh" "$HOME/.p10k.zsh"

######################## Git Settings ########################
# Don't open 
git config --global pager.branch false
# From https://stackoverflow.com/questions/1822849/what-are-these-ms-that-keep-showing-up-in-my-files-in-emacs
# Commenting because caused issue when cloning repos
# git config --global core.autocrlf true

######################## Fav Repos ########################
local dev_dir=$HOME/dev
mkdir -p $dev_dir
git clone https://github.com/Bierro/sandboxes.git  $dev_dir/sandboxes
git clone https://github.com/github/gitignore.git  $dev_dir/gitignore
git clone https://github.com/Bierro/data-analytics.git  $dev_dir/data-analytics