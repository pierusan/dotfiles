#!/bin/bash

# MAKE SURE TO RUN apt.sh first

######################## Zsh Setup ########################
# Setup zsh as default
chsh -s $(which zsh)
# Install Oh My Zsh Unattended
# https://github.com/ohmyzsh/ohmyzsh#unattended-install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# Powerlevel10k theme
git clone --depth=1 git@github.com:romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# Custom plugins
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone git@github.com:zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone git@github.com:lukechilds/zsh-nvm ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm
# Symlink .zshrc
dotfiles_dir=$(dirname $(readlink -f $0))
echo "dotfiles_dir=$dotfiles_dir"
[[ -r "$HOME/.zshrc" ]] && mv "$HOME/.zshrc" "$HOME/.zshrc_system"
ln -s "$dotfiles_dir/.zshrc" "$HOME/.zshrc"
ln -s "$dotfiles_dir/.p10k.zsh" "$HOME/.p10k.zsh"

######################## Git Settings ########################
# Leave pager results printed in the terminal
# https://serebrov.github.io/html/2014-01-04-git-log-and-less-keep-output.html 
git config --global --replace-all core.pager "less -XF"

# From https://stackoverflow.com/questions/1822849/what-are-these-ms-that-keep-showing-up-in-my-files-in-emacs
# Commenting because caused issue when cloning repos
# git config --global core.autocrlf true
# From https://code.visualstudio.com/docs/remote/troubleshooting#_resolving-git-line-ending-issues-in-wsl-resulting-in-many-modified-files
# Maybe should try this instead:
# git config --global core.autocrlf input

# Try to fast-forward when pulling so you're just notified if it fails and you
# can then take further action like git reset --hard origin/my_branch if someone
# has rebased the remote branch
git config --global pull.ff only

######################## Fav Repos ########################
dev_dir=$HOME/dev
mkdir -p $dev_dir
git clone git@github.com:Bierro/sandboxes.git  $dev_dir/sandboxes

######################## Reload session ########################
exec zsh
