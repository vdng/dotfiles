""""""""""""""""""""""""""""""""""""""""""""""""
"                  PLUGINS                     "
""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
call plug#begin('~/.vim/plugged')

" Linter
Plug 'dense-analysis/ale'

" Fast fold
Plug 'Konfekt/FastFold'

" Status line plugin
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Tabular
Plug 'godlygeek/tabular'

" Git gutter
Plug 'airblade/vim-gitgutter'

" Colorizer
Plug 'chrisbra/Colorizer'

" Display indent levels
Plug 'Yggdroot/indentLine'

" Lighthaus Theme
Plug 'lighthaus-theme/vim-lighthaus'

" VimWiki
Plug 'vimwiki/vimwiki'

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""
"                  GIT GUTTER                  "
""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = '1'
let g:gitgutter_sign_removed_above_and_below = ''
let g:gitgutter_sign_modified_removed = ''


""""""""""""""""""""""""""""""""""""""""""""""""
"                  VIM AIRLINE                 "
""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
let g:airline_theme = 'lighthaus'
let g:airline#extensions#tabline#enabled = 1

""""""""""""""""""""""""""""""""""""""""""""""""
"                    VIMWIKI                   "
""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimwiki_list = [{'path': '~/personal-wiki'}]

""""""""""""""""""""""""""""""""""""""""""""""""
"                      COC                     "
""""""""""""""""""""""""""""""""""""""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

