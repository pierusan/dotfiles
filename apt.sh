#!/bin/bash

######################## Apt Packages ########################
sudo apt update
sudo apt -y upgrade
sudo apt install -y \
    tree \
    git \
    curl \
    zsh \
    screenfetch `# Cute printout of distro info (also use 'distro')` \
    build-essential `# Used for VSCode?` \
    gdb `# C++ debugger` \
    cmake \
    clang-format-8 \
    python3-venv

######################## C++ Development ########################
sudo ln -s /usr/bin/clang-format-8 /usr/bin/clang-format

######################## Web Development ########################
# Reminder: nvm is already installed as a zsh plugin
sudo snap install --classic heroku
npm install netlify-cli -g # Need to run `netlify login` later