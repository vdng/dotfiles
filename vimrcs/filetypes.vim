""""""""""""""""""""""""""""""""""""""""""""""""
"                     LUA                      "
""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.lua set shiftwidth=2
autocmd BufNewFile,BufRead *.lua set softtabstop=2

""""""""""""""""""""""""""""""""""""""""""""""""
"                   LILYPOND                   "
""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.ly set shiftwidth=2
autocmd BufNewFile,BufRead *.ly set softtabstop=2

filetype off
set runtimepath+=/home/vincent/lilypond/usr/share/lilypond/current/vim/
filetype on

""""""""""""""""""""""""""""""""""""""""""""""""
"                     TEX                      "
""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.tex set linebreak
let g:tex_conceal = ''

""""""""""""""""""""""""""""""""""""""""""""""""
"                   MARKDOWN                   "
""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd BufNewFile,BufRead *.md set textwidth=100
autocmd BufNewFile,BufRead *.md set linebreak

""""""""""""""""""""""""""""""""""""""""""""""""
"                   VIM WIKI                   "
""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.wiki set linebreak

""""""""""""""""""""""""""""""""""""""""""""""""
"                     LUA                      "
""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.yaml set shiftwidth=4
autocmd BufNewFile,BufRead *.yaml set softtabstop=4
