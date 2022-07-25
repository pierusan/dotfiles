# dotfiles

Personal setting and configurations.

## MacOS setup

- Setup computer and apple ID
- Mac System Preferences
  - Dock: reduce size, remove recent apps, and remove most Mac apps
  - In language and Regions, set 24h and Celcius
  - Add International US keyboard Input source
  - Choose a background theme
- In a terminal run `git --version` to install `git` (shipped with the XCode
  command line tools)
- In Safari, go to this Github dotfiles Readme and follow the [instructions
  below](#git-setup) to clone this repo
- In a terminal, go to the root of this repo and:
  - Run `./all.sh` to setup zsh themes, plugins, aliases, functions, etc.. ,
    and clone the `sandboxes` repo
  - Run `./mac.sh` to install brew along with your favorite applications
- Open Chrome and sign in to your account
- Open VSCode and turn on settings sync
- Setup iterm
  - Download [Source Code
    Pro](https://fonts.google.com/specimen/Source+Code+Pro) and install it to
    Font book
  - Install shell integrations for access to `imgcat`
  - Install `iterm/com.googlecode.iterm2.plist` file as a profile. [Instructions](https://stackoverflow.com/a/38263589/5721547)
  - Look at the status of this:
    https://github.com/romkatv/powerlevel10k#horrific-mess-when-resizing-terminal-window
- Setup Google Drive and add favorite directories to 'Favorites'
- Install some pyenv versions and set the global version to use
  - Run `./all_poetry.sh` once Python is installed to install Poetry
- Setup `Screenshots` directory for Cmd+Shft+5 stuff
- Setup touch ID for sudo
  - Add `auth sufficient pam_tid.so` to the end of the `/etc/pam.d/sudo` file
    (running `sudo su -`, and then `vi /etc/pam.d/sudo` should do it)

## Windows setup

- Rename device name in _Settings>System>About_
- Double check Windows username (if needs to be renamed check the instructions
  from [this Youtube video](https://www.youtube.com/watch?v=w5N2aaiToiQ))
- Check and install updates
- Remove unwanted programs
- [Install WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
  - Install distro such as Ubuntu 20.04
  - Add `\\wsl$` path to quick access in the explorer
- Follow the [instructions below](#git-setup) to clone this
  repo
- In WSL, go to the root of this repo and:
  - Run `sudo ./linux.sh` to install packages like `zsh`, `cmake`, etc...
  - Run `./all.sh` to setup zsh themes, plugins, aliases, functions, etc.. ,
    and clone the `sandboxes` repo
- [Install Winget](https://docs.microsoft.com/en-us/windows/package-manager/winget/)
- From WSL, run `powershell.exe -ExecutionPolicy ByPass -File winget.ps1` to install
- Set preferences
  - Configure Taskbar
  - Configure Start Menu
  - Configure Default Apps
  - Use `windows_terminal_settings.json` as inspiration for Windows Terminal
    settings (Ctrl+,)

## Git setup

- Generate a new SSH key and add it to ssh-agent |
  [instructions](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- Add the SSH key to your Github account |
  [instructions](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
- Set `git config --global user.name FIRST_NAME LAST_NAME` and `git config --global user.email EMAIL`
- Clone this repo over ssh into a new directory `$HOME/dev`
  - `mkdir -p $HOME/dev && cd $HOME/dev`
  - `git clone git@github.com:Bierro/dotfiles.git`
