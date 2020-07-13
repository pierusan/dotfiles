#!/bin/bash

######################## Apt Packages ########################
sudo apt update
sudo apt -y upgrade
sudo apt install -y \
    git \
    curl \
    zsh \
    screenfetch `# Cute printout of distro info (also use 'distro')` \
    python3-venv \
    gdb `#C++ debugger` \
    clang-format-8 \
    build-essential `# Used for VSCode?`

sudo ln -s /usr/bin/clang-format-8 /usr/bin/clang-format