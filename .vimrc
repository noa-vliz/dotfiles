" Vim-Plug設定
call plug#begin('~/.vim/plugged')

" Clang Completeプラグインを追加
Plug 'Rip-Rip/clang_complete'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()


" clang_completeプラグインの設定
let g:clang_use_library = 1
let g:clang_library_path = '/usr/lib/llvm-11/lib'
let g:clang_snippets = 1
let g:clang_complete#snippets_engine = 'UltiSnips'
let g:clang_library_path = '/usr/lib/libclang.so.17'



" 自動補完を有効にする
autocmd FileType c setlocal omnifunc=clang_complete#Complet
