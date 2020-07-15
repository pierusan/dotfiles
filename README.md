# dotfiles
Personal setting and configurations.

## Recommended Git pre-requisites
* Generate ssh key `ssh-keygen -t rsa -b 4096` and add public key to Github
* Set `git config --global user.name NAME` and `git config --global user.email EMAIL`
* Clone this repo over ssh into a new directory `$HOME/dev` 
    * `mkdir -p $HOME/dev && cd $HOME/dev`
    * `git clone git@github.com:Bierro/dotfiles.git`

## Usage
* Run `sudo brew.sh` **OR** `sudo apt.sh` based on your platform to first install packages such as zsh
* Run `setup.sh`
* On WSL, use `windows_terminal_settings.json` as inspiration for Windows Terminal settings (Ctrl+,)


