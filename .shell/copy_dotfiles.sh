
installer_dir="$(pwd)"
home_dir="$HOME"


function copy_files(){
	rsync -av --quiet \
  		--include='/.*/' \
  		--include='/.*' \
  		--exclude='*' \
  		--exclude='.git/' \
  		"$installer_dir/" "$home_dir/"
	
	sudo rsync -av --quiet \
		"$installer_dir/scripts/" "/usr/local/bin/"
}



