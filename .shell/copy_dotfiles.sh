installer_dir="$(pwd)"
home_dir="$HOME"
 
 
function copy_files(){
    rsync -av --inplace --ignore-times \
        --exclude='/.git/' \
        --exclude='/.git/**' \
        --exclude='/.shell/' \
        --exclude='/.shell/**' \
        --include='/**/.*' \
        --include='/**/.*/**' \
        --exclude='*' \
        "$installer_dir/" "$home_dir/"

    sudo rsync -av --inplace --ignore-times \
        "$installer_dir/scripts/" "/usr/local/bin/"
}


