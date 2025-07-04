function post_install() {
    echo -e "\e[1;34m[+] Running post_install...\e[0m"

    
    echo -e "\n\e[1;92m=> Downloading wallpapers...\e[0m"

    # download wallpaper from my website
    mkdir -p ~/Pictures
    curl https://noa-vliz.site/wallpaper/wallpaper1.jpg -o ~/Pictures/wallpaper1.jpg
    curl https://noa-vliz.site/wallpaper/wallpaper2.png -o ~/Pictures/wallpaper2.png

    echo -e "\n\e[1;92m=> Generating fluxbox menu...\e[0m"
    mmaker -f Fluxbox

    # enable services
    echo -e "\n\e[1;92m=> Enabling services...\e[0m"
    for svc in dbus emptty; do
        target="/var/service/$svc"
        source="/etc/sv/$svc"

        if [ -L "$target" ] || [ -e "$target" ]; then
            echo "[!] Symlink or file already exists: $target"
        else
            sudo ln -s "$source" "$target" && echo "Created symlink: $source -> $target"
        fi
    done
}


