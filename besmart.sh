#!/bin/bash

source scripts/utils/bashlib.sh
colors

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
  if ! [ -f "/usr/share/fonts/HackNerdFont-Regular.ttf" ]; then
    echo "...Setting fonts"
    cp ./fonts/HackNerdFont-Regular.ttf "/usr/share/fonts"
    echo "...Done"
  fi
}

programs() {
  addHackFont

  echo "...Installing programs"
  # Basics
  pacman -S --needed --noconfirm wezterm xclip libreoffice-still noto-fonts-emoji noto-fonts-extra ttf-font-awesome firefox-developer-edition

  # Tools
  pacman -S --needed --noconfirm keepassxc zoxide glow nodejs-lts-iron npm ripgrep nvtop obsidian

  # Entertainment
  pacman -S --needed --noconfirm spotify-launcher discord signal-desktop

  # AUR
  yay -S --noconfirm --needed dropbox neovim-git tmux-bash-completion-git
  echo "...done"
}

configs() {
  echo "...Setting all configs"
  cp -lfr ./configs/* $HOME/.config/
  cp -lfr ./configs/.* $HOME/.config/
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
