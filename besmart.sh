#!/bin/bash

# Colors using ANSI escape codes
RED='\033[0;31m'
REDBACKGROUND='\033[0;41m'
BOLDRED='\033[1;31m'
GREEN='\033[0;32m'
GREENBACKGROUND='\033[0;42m'
BOLDGREEN='\033[1;32m'
YELLOW='\033[0;33m'
YELLOWBACKGROUND='\033[0;43m'
BOLDYELLOW='\033[1;33m'
BLUE='\033[0;34m'
BLUEBACKGROUND='\033[0;44m'
BOLDBLUE='\033[1;34m'
PURPLE='\033[0;35m'
PURPLEBACKGROUND='\033[0;45m'
BOLDPURPLE='\033[1;35m'
CYAN='\033[0;36m'
BOLDCYAN='\033[1;36m'

ITALICGREY='\033[3;90m'
NC='\033[0m' # No Color

echo_color() {
    local color="$1"
    local text="$2"
    echo -e "${!color}$text${NC}"
}

# Need AUR
if ! [[ $(command -v yay) ]]; then
  read -p "AUR not found - install latest version? [y/n]: " response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf ./yay/
  else
    echo "Ok, goodbye!"
    exit 1
  fi
fi

addHackFont() {
  if ! [ -d "/usr/share/fonts/nerdfonts" ]; then
    sudo mkdir -p /usr/share/fonts/nerdfonts
    sudo mv ./fonts/* /usr/share/fonts/nerdfonts/
    sudo fc-cache -fv
  fi
}

programs() {
  addHackFont

  echo "...Installing programs"
  # Basics
  sudo pacman -S --needed --noconfirm wezterm xclip libreoffice-still noto-fonts-emoji noto-fonts-extra ttf-font-awesome firefox-developer-edition less wl-clipboard

  # Tools
  sudo pacman -S --needed --noconfirm keepassxc zoxide glow nodejs-lts-iron npm ripgrep nvtop obsidian

  # Entertainment
  sudo pacman -S --needed --noconfirm spotify-launcher discord signal-desktop

  # AUR
  yay -S --noconfirm --needed dropbox neovim-git 
  echo "...done"
}

configs() {
  echo "...Setting all configs"
  cp -lfr ./configs/* $HOME/.config/

  ./external/mybashrc/load.sh
  echo "...Done"
}

# User input
if [[ $# == 0 ]]; then
  $0 -h
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
  -h | --help)
    echo
    echo_color BOLDGREEN "=:| Automated Setup Script |:="
    echo_color ITALICGREY "Only one flag at at time."
    echo
    echo
    echo_color YELLOW "-h, --help"
    echo "  Displays this help message"
    echo
    echo "---"
    echo
    echo_color YELLOW "-a, --all"
    echo " Sets up everything in one go: Installs programs and sets configs"
    echo
    echo_color YELLOW "-p, --programs"
    echo " Install programs"
    echo
    echo_color YELLOW "-c, --configs"
    echo " Set configs"
    echo
    echo "---"

    shift 1
    ;;
  -a | --all)
    programs
    configs
    shift 1
    ;;
  -p | --programs)
    programs
    shift 1
    ;;
  -c | --configs)
    configs
    shift 1
    ;;
  *)
    echo "Unknown flag: $1"
    echo "$(basename $0) [-h | --help]"
    exit
    ;;
  esac
done

