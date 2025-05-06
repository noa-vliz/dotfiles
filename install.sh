#!/bin/bash

set -euo pipefail
LANG=C

installer_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$installer_dir"

source ./.shell/post-install.sh
source ./.shell/install_packages.sh
source ./.shell/copy_dotfiles.sh

source /etc/os-release

if ! [[ "$ID" = "void" ]];then 
	echo -e "This script needs to be run on Void Linux."
	exit 1
fi

echo -e "\n\e[1;32m=== Dotfiles Installer ===\e[0m"
echo "This script will install packages and copy your configuration files (dotfiles)."
echo -e "You can review the source code if you want to know exactly what happens.\n"

# Confirmation loop
while true; do
    read -rp "Proceed with installation? [y/n]: " input
    input="${input,,}"  # lowercase

    case "$input" in
        y|yes)
            echo -e "\n\e[1;34m[+] Installing packages...\e[0m"
            echo "-> This requires sudo privileges."
            sudo -v  # Prompt for sudo

            install_packages

	    sleep 1
            echo -e "\n\e[1;33m[+] Copying dotfiles...\e[0m"
            copy_files

	    sleep 1
	    post_install

            echo -e "\n\e[1;32mInstallation complete!\e[0m"
            break
            ;;
        n|no)
            echo -e "\n\e[1;31mInstallation aborted by user.\e[0m"
            break
            ;;
        *)
            echo "Please enter 'y' or 'n'."
            ;;
    esac
done

