#!/bin/bash

######################### Brew #########################
# Install brew and make sure formulae are up to date
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update

# GNU coreutils
brew install \
    coreutils

# C++
brew install \
    cmake

# Build dependencies for python installs
brew install \
    openssl \
    readline \
    sqlite3 \
    xz \
    zlib

# Python management
brew install \
    pyenv

# Python needs to be installed to install poetry, so we will need to call the
# poetry install script separately afterwards as specified by the readme

# Apps
brew install --cask \
    blender \
    docker \
    figma \
    firefox \
    google-chrome \
    google-drive \
    insomnia \
    iterm2 \
    messenger \
    notion \
    rectangle \
    slack \
    spotify \
    visual-studio-code \
    whatsapp \
    zoom

######################## Web Development ########################
# Reminder: nvm is already installed as a zsh plugin
nvm install --lts # Node with long term support
sudo snap install --classic heroku
npm install netlify-cli -g # Need to run `netlify login` later