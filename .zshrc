# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/pierre/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME=""
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="pure"
# ZSH_THEME="alanpeabody" # Pretty cool theme but the return time is too long 
# ZSH_THEME="random"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# Plugins suggested here: https://www.sitepoint.com/zsh-tips-tricks/
plugins=(z git zsh-syntax-highlighting zsh-autosuggestions command-not-found rsync)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

######################## Variables ########################
local dev_dir="$HOME/dev"


######################## Aliases ########################
# Custom Aliases
alias cdd="cd /mnt/c/Users/pierr/Downloads"
alias pyactds="source ${dev_dir}/python_venv/data_science_env/bin/activate"
alias gbvv="git branch -vv"
## Use docker without sudo (https://docs.docker.com/install/linux/linux-postinstall/) ##
alias dockerrootless='sudo usermod -aG docker $USER; newgrp docker'

#Aliases recommended from https://www.sitepoint.com/zsh-commands-plugins-aliases-tools/
alias myip="curl http://ipecho.net/plain; echo"
# alias reload='source ~/.zshrc'
# Recommended reload: https://github.com/ohmyzsh/ohmyzsh/wiki/FAQ#how-do-i-reload-the-zshrc-file
alias reload='exec zsh'
alias distro='cat /etc/*-release'
alias sapu='sudo apt-get update'

#TODO: Look at more aliases in https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/common-aliases
alias f="find . -iname"
alias fd="find . -type d -name"
alias ff="find . -type f -name"


######################## Custom Functions ########################
function copypath() {
    [[ -r ${1:-} ]] || echo "Usage copypath PATH"
    print -n $1 | clipcopy
}

function recordscreen() {
  [[ -r ${1:-} ]] || echo "Usage record_screen PATH (w) (h) (x) (y)"
  screen_w=2160
  screen_h=3840
  top_bar=39
  video_name=$1
  if [ -z "$2" ]; then video_w=${screen_w}; else video_w=$2; fi
  if [ -z "$3" ]; then video_h=$((${screen_w}/5)); else video_h=$3; fi
  if [ -z "$4" ]; then video_x=0; else video_x=$4; fi
  if [ -z "$5" ]; then video_y=${top_bar}; else video_y=$5; fi
  ffmpeg -y -f x11grab -s ${video_w}x${video_h} -r 30 -i :0.0+${video_x},${video_y} -qscale:v 0 -vcodec huffyuv $1.avi
  ffmpeg -y -i $1.avi -qscale:v 0 -vcodec mpeg4 $1.mp4

  rm $1.avi
  vlc $1.mp4
}

function convertavitomp4() {
  [[ -r ${1:-} ]] || { echo "Usage: convertavitomp4 FILE"; return 1; }
  if ! [ "${1##*.}" = "avi" ]; then { echo "Not an avi file ${1}"; return 1; } fi
 
  avi_video_path=$1
  video_dir=$(dirname $avi_video_path)
  video_name=$(basename $avi_video_path .avi)
  mp4_video_path="$video_dir/$video_name.mp4"
  # echo "avi_video_path:$avi_video_path mp4_video_path:$mp4_video_path"

  # With rotation
  ffmpeg -y -i $avi_video_path -vf transpose=1 -qscale:v 0 -vcodec mpeg4 $mp4_video_path
  rm $avi_video_path
  vlc $mp4_video_path
}


######################## Powerlevel10k config ########################
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


######################## Powerlevel10k config ########################
# Ctrl-U was not working
# https://unix.stackexchange.com/questions/522663/ctrl-u-deletes-whole-line-regardless-of-cursor-position
bindkey \^U backward-kill-line

# Not super sure where this came from. Prolly no need to have it in the future
# Maybe came from this: https://github.com/microsoft/WSL/issues/352
umask 0002