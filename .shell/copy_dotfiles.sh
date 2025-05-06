
installer_dir="$(pwd)"
home_dir="$HOME"


function copy_files(){

	rsync -av \
  		--exclude='/.git/' \
  		--exclude='/.shell/' \
  		--include='/**.*/' \
  		--include='/**/.*' \
  		--exclude='*' \
  		"$installer_dir/" "$home_dir/"

	sudo rsync -av \
		"$installer_dir/scripts/" "/usr/local/bin/"
}



