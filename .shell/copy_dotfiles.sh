installer_dir="$(pwd)"
home_dir="$HOME"
 
 
function copy_files(){
    # 隠しファイルと隠しディレクトリ（.gitと.shellを除く）をコピー
    rsync -av --inplace --ignore-times \
        --exclude='.git' \
        --exclude='.shell' \
        --include='.*' \
        --include='.*/**' \
        --exclude='*' \
        "$installer_dir/" "$home_dir/"
 
    # スクリプトを /usr/local/bin/ にコピー
    sudo rsync -av --inplace --ignore-times \
        "$installer_dir/scripts/" "/usr/local/bin/"


}

