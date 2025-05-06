packages=(
        "fluxbox"
        "xorg"
        "firefox"
        "dunst"
        "fcitx"
        "xterm"
        "menumaker"
        "noto-fonts-cjk"
        "noto-fonts-emoji"
	"emptty"
	"vim-huge"
	"git"
	"rsync"
	"flameshot"
	"alsa-utils"
	"libnotify"
	"dbus"
	"dbus-libs"
	"dbus-x11"
)

function search_packages(){
	printf "\e[93m=>\e[0;1m Checking for installed packages...\e[0m\n"
        for i in "${!packages[@]}"; do
                if xbps-query -p pkgver "${packages[$i]}" > /dev/null 2>&1; then
			printf "${packages[$i]}: \e[32mok\e[0m\n"
                        unset 'packages[i]'
		else
			printf "${packages[$i]}: \e[31mno\e[0m\n"
                fi
        done
        packages=("${packages[@]}")
}






function install_packages(){
	search_packages

	if (( ${#packages[@]} > 0 )); then
    		printf "\e[92m=>\x1b[0;1m Installing packages...\n"
    		sudo xbps-install -S "${packages[@]}" -y
	else
    		printf "\e[32mAll packages are already installed!\e[0m\n"
	fi
}
