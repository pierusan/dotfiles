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

sudo ln -s /usr/bin/clang-format-8 /usr/bin/clang-format