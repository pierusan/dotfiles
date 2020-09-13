# dotfiles
Personal setting and configurations.

## Windows pre-requisites
* Rename computer
* Check Windows username
* Check and install updates
* Remove unwanted programs
* [Install WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
    * Install distro such as Ubuntu 20.04
    * Add `\\wsl$` path to quick access in the explorer
* In WSL, follow the steps outlined in the paragraphs below
* [Install Winget](https://docs.microsoft.com/en-us/windows/package-manager/winget/)
* From WSL, run `powershell.exe -ExecutionPolicy ByPass -File winget.ps1`
* Set preferences
    * Configure Taskbar
    * Configure Start Menu
    * Configure Default Apps 
    * Use `windows_terminal_settings.json` as inspiration for Windows Terminal settings (Ctrl+,)
    * Set Device Encryption


## Recommended Git pre-requisites
* Generate ssh key `ssh-keygen -t rsa -b 4096` and add public key to Github
* Set `git config --global user.name NAME` and `git config --global user.email EMAIL`
* Clone this repo over ssh into a new directory `$HOME/dev` 
    * `mkdir -p $HOME/dev && cd $HOME/dev`
    * `git clone git@github.com:Bierro/dotfiles.git`

## Usage
* Run `sudo ./brew.sh` **OR** `sudo ./apt.sh` based on your platform to first install packages such as zsh
* Run `/setup.sh`


