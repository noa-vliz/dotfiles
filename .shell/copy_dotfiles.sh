
installer_dir="$(pwd)"
home_dir="$HOME"


function copy_files(){
	rsync -av \
  		--include='/.*/' \
  		--include='/.*' \
  		--exclude='*' \
  		--exclude='.git/' \
  		"$installer_dir/" "$home_dir/"

	mkdir -p "$home_dir/.fluxbox"
	rsync -av \
  		--exclude='.' \
  		--exclude='..' \
		"$installer_dir/.fluxbox" "$home_dir/.fluxbox"
	
	sudo rsync -av \
		"$installer_dir/scripts/" "/usr/local/bin/"
}



