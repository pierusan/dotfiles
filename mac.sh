#!/bin/bash

DOTFILES_DIR=$(cd "$(dirname "$0")"; pwd -P)

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
    mullvadvpn \
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


######################## Bing Wallpaper ########################
mkdir -p ~/bin
ln -s $DOTFILES_DIR/mac-bing-wallpaper/mac-bing-wallpaper.sh ~/bin/mac-bing-wallpaper.sh
ln -s $DOTFILES_DIR/mac-bing-wallpaper/com.mac-bing-wallpaper.plist ~/Library/LaunchAgents/com.mac-bing-wallpaper.plist
launchctl load ~/Library/LaunchAgents/com.mac-bing-wallpaper.plist

######################## Source Code Pro ########################
pushd ~/Downloads
mkdir font-downloads
cd font-downloads
curl https://fonts.google.com/download\?family\=Source%20Code%20Pro --output SourceCodePro.zip
unzip SourceCodePro.zip
rsync --include '*.ttf' --exclude '*' static/* ~/Library/Fonts/
cd ..
rm -r font-downloads
popd

######################## iterm ########################
# TODO: Should check that this actually works in the next install
ln -s $DOTFILES_DIR/iterm/com.googlecode.iterm2.plist ~/Library/Preferences/