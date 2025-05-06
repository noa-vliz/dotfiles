#!/bin/bash

packages=(
    fluxbox
    xorg
    firefox
    dunst
    fcitx
    xterm
    menumaker
    noto-fonts-cjk
    noto-fonts-emoji
    emptty
    vim-huge
    git
    rsync
    flameshot
    alsa-utils
    libnotify
    dbus
    dbus-libs
    dbus-x11
    curl
)

missing=()

function search_packages() {
    echo -e "\e[1;93m=> Checking installed packages...\e[0m"
    for pkg in "${packages[@]}"; do
        if xbps-query -p pkgver "$pkg" &>/dev/null; then
            echo -e "$pkg: \e[32mOK\e[0m"
        else
            echo -e "$pkg: \e[31mNot Installed\e[0m"
            missing+=("$pkg")
        fi
    done
}

function install_packages() {
    search_packages

    if (( ${#missing[@]} > 0 )); then
        echo -e "\n\e[1;92m=> Installing missing packages...\e[0m"
        sudo xbps-install -Sy "${missing[@]}"
    else
        echo -e "\n\e[1;32mAll packages are already installed.\e[0m"
    fi
}
