""""""""""""""""""""""""""""""""""""""""""""""""
"                   GENERAL                    "
""""""""""""""""""""""""""""""""""""""""""""""""
" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

source ~/.vim/vimrcs/bepo.vim
source ~/.vim/vimrcs/plugins.vim
source ~/.vim/vimrcs/filetypes.vim

""""""""""""""""""""""""""""""""""""""""""""""""
"                     GUI                      "
""""""""""""""""""""""""""""""""""""""""""""""""
" Number of context lines to see when scrooling at the edges
set scrolloff=7

" Better command line completion
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Leave a buffer without saving it
set hidden

" Search : search while typing, highlight,
"          case when there is a capital letter
set incsearch
set hlsearch
set ignorecase
set smartcase

" Show number of lines : relative for normal mode
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Show command in status line
set showcmd

" change cursor type according to mode
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' |
    \   silent execute '!echo -ne "\e[5 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[3 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

" highlight cursor line
set cursorline

" only highlight in current window
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Give more space for displaying messages.
set cmdheight=2

""""""""""""""""""""""""""""""""""""""""""""""""
"               COLORS AND FONTS               "
""""""""""""""""""""""""""""""""""""""""""""""""

" Colorscheme
let g:lighthaus_vsplit_line_light = 1
colorscheme lighthaus

" True colors
set termguicolors

" Syntax highlighting
syntax enable

" utf-8 encoding
set encoding=utf-8

""""""""""""""""""""""""""""""""""""""""""""""""
"             TEXT, TAB AND INDENTS            "
""""""""""""""""""""""""""""""""""""""""""""""""
" Dont't use the actual tab character and set indenting to 4 spaces
set expandtab
set shiftwidth=4
set softtabstop=4

" Indent
set autoindent
set smartindent

" Invisible chars
set listchars=nbsp:~,tab:>-,extends:>,precedes:<,trail:¤
set list

""""""""""""""""""""""""""""""""""""""""""""""""
"                  VISUAL MODE                 "
""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""
"               HELPER FUNCTIONS               "
""""""""""""""""""""""""""""""""""""""""""""""""
" Don't close window when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

