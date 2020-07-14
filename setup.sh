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
dotfiles_dir=$(dirname $(readlink -f $0))
echo "dotfiles_dir=$dotfiles_dir"
[[ -r "$HOME/.zshrc" ]] && mv "$HOME/.zshrc" "$HOME/.zshrc_system"
ln -s "$dotfiles_dir/.zshrc" "$HOME/.zshrc"
ln -s "$dotfiles_dir/.p10k.zsh" "$HOME/.p10k.zsh"

######################## Git Settings ########################
# Print git stuff directly in terminal
git config --global pager.branch false
git config --global pager.log false
# git config --global core.pager cat

# From https://stackoverflow.com/questions/1822849/what-are-these-ms-that-keep-showing-up-in-my-files-in-emacs
# Commenting because caused issue when cloning repos
# git config --global core.autocrlf true
# From https://code.visualstudio.com/docs/remote/troubleshooting#_resolving-git-line-ending-issues-in-wsl-resulting-in-many-modified-files
# Maybe should try this instead:
# git config --global core.autocrlf input

######################## Fav Repos ########################
dev_dir=$HOME/dev
mkdir -p $dev_dir
git clone https://github.com/Bierro/sandboxes.git  $dev_dir/sandboxes
git clone https://github.com/github/gitignore.git  $dev_dir/gitignore
