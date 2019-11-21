syntax on
filetype on
filetype indent on
filetype plugin on
syn sync fromstart
set autoindent
set autoread
set autowrite
set background=dark
set backspace=2
set cinoptions=>2
set cmdheight=2
set encoding=utf-8
set expandtab
set hidden
set ignorecase
set incsearch
set joinspaces
set laststatus=2
set magic
set modeline
set modelines=3
set nobackup
set nocompatible
set noerrorbells
set nohlsearch
set nostartofline
set nowrap
set nowritebackup
set numberwidth=5
set ruler
set scrolloff=3
set shell=bash
set shiftwidth=2
set shortmess=at
set showcmd
set showmatch
set showmode
set smartcase
set smartindent
set softtabstop=2
set splitbelow
set splitright
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set switchbuf=useopen
set synmaxcol=2048
set t_ti= t_te=
set tabstop=2
set textwidth=0
set ttyfast
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000
set viminfo='20,\"50
set wildmenu
set wildmode=longest,list
"colorscheme molokai
"hi Visual ctermbg=DarkGrey guibg=DarkGrey

" Treat _ as word boundary
" set iskeyword-=_

call pathogen#infect()
call pathogen#helptags()

if has("autocmd")
  autocmd BufEnter * :syntax sync fromstart
  autocmd BufEnter * set relativenumber
  autocmd BufEnter * set number

  augroup cprog
    au!
    autocmd BufRead *       set formatoptions=tcql nocindent comments&
    autocmd BufRead *.c,*.h set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
  augroup END

  augroup gzip
    au!
    autocmd BufReadPre,FileReadPre	*.gz set bin
    autocmd BufReadPre,FileReadPre	*.gz let ch_save = &ch|set ch=2
    autocmd BufReadPost,FileReadPost	*.gz '[,']!gunzip
    autocmd BufReadPost,FileReadPost	*.gz set nobin
    autocmd BufReadPost,FileReadPost	*.gz let &ch = ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost	*.gz execute ":doautocmd BufReadPost " . expand("%:r")

    autocmd BufWritePost,FileWritePost	*.gz !mv <afile> <afile>:r
    autocmd BufWritePost,FileWritePost	*.gz !gzip <afile>:r

    autocmd FileAppendPre			*.gz !gunzip <afile>
    autocmd FileAppendPre			*.gz !mv <afile>:r <afile>
    autocmd FileAppendPost		*.gz !mv <afile> <afile>:r
    autocmd FileAppendPost		*.gz !gzip <afile>:r
  augroup END

  augroup bzip2
    au!
    autocmd BufReadPre,FileReadPre        *.bz2 set bin
    autocmd BufReadPre,FileReadPre        *.bz2 let ch_save = &ch|set ch=2
    autocmd BufReadPost,FileReadPost      *.bz2 |'[,']!bunzip2
    autocmd BufReadPost,FileReadPost      *.bz2 let &ch = ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost      *.bz2 execute ":doautocmd BufReadPost " . expand("%:r")

    autocmd BufWritePost,FileWritePost    *.bz2 !mv <afile> <afile>:r
    autocmd BufWritePost,FileWritePost    *.bz2 !bzip2 <afile>:r

    autocmd FileAppendPre                 *.bz2 !bunzip2 <afile>
    autocmd FileAppendPre                 *.bz2 !mv <afile>:r <afile>
    autocmd FileAppendPost                *.bz2 !mv <afile> <afile>:r
    autocmd FileAppendPost                *.bz2 !bzip2 -9 --repetitive-best <afile>:r
  augroup END

  augroup mailauto
    au!
    au FileType mail set textwidth=72
  augroup END

  augroup highlight_bg
    au!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
  augroup END

  augroup no_simultaneous_edits
    au!
    au SwapExists * let v:swapchoice = 'o'
    "au SwapExists * echomsg ErrorMsg
    au SwapExists * echo 'Duplicate edit session (readonly)'
    au SwapExists * echohl None
  augroup END

  " Remove trailing whitespace
  let noStripTrailingWhitespaceFiletypes = ['diff']
  autocmd BufWritePre * if index(noStripTrailingWhitespaceFiletypes, &ft) < 0 | :%s/\s\+$//e
endif " has ("autocmd")

function! ExtractVariable()
    let name = input("Variable name: ")
    if name == ''
        return
    endif
    normal! gv
    exec "normal c" . name
    exec "normal! O" . name . " = "
    normal! $p
endfunction

function! InlineVariable()
    :normal "ayiw
    :normal 4diw
    :normal "bd$
    :normal dd
    normal k$
    exec '/\<' . @a . '\>'
    exec ':.s/\<' . @a . '\>/' . @b
endfunction

let mapleader=","
nnoremap <leader><leader> <c-^>
vnoremap <leader>re :call ExtractVariable()<cr>
nnoremap <leader>ri :call InlineVariable()<cr>
nnoremap <leader>d :r!date +'\%a \%b \%d, \%Y'<cr>o----------------<esc>o
nnoremap <leader>qq :wa<cr>:qa<cr>

" Make <leader>' switch between ' and "
nnoremap <leader>' ""yls<c-r>={'"': "'", "'": '"'}[@"]<cr><esc>

" Switch between relative and absolute numbering
function! g:ToggleNumberMode()
  if (&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
map <leader>l :call g:ToggleNumberMode()<cr>

" Rename current file
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New filename: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>rf :call RenameFile()<cr>

" map q work again with minibufexplorer
"cnoreabbrev <expr> q ((getcmdtype() is# ':' && getcmdline() is# 'q')?('qa'):('q'))

" Open minibufexplorer above other windows
let g:miniBufExplBRSplit = 0

" when I type :W, I mean :w
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

" toggle paste
nnoremap <silent> <leader>p :call TogglePaste()<cr>
function! TogglePaste()
  if &paste == 0
    set paste
    echo "Paste On"
  else
    set nopaste
    echo "Paste Off"
  endif
endfunction

" toggle hlsearch
nnoremap <silent> <leader>h :set hlsearch!<cr>

" Window navigation shortcuts
nnoremap <leader>w <c-w>
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nnoremap <Esc>[5D :bp<cr>
nnoremap <Esc>[5C :bn<cr>

nnoremap <leader>1 :b1<cr>
nnoremap <leader>2 :b2<cr>
nnoremap <leader>3 :b3<cr>
nnoremap <leader>4 :b4<cr>
nnoremap <leader>5 :b5<cr>
nnoremap <leader>6 :b6<cr>
nnoremap <leader>7 :b7<cr>
nnoremap <leader>8 :b8<cr>
nnoremap <leader>9 :b9<cr>
nnoremap <leader>0 :b10<cr>

" yank to end of line
nmap Y y$

" Prettify XML
nmap <leader>x :%s/></>\r</g<cr>:0<cr>=:$<cr>

" Tab autocomplete unless at beginning of line
function! InsertTabWrapper()
  let line = getline('.')                     " current line

  let substr = strpart(line, -1, col('.')+1)  " from the start of the current
                                              " line to one character right
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  endif

  return "\<C-n>"                     " existing text matching
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-p>

" Highlight 80 column soft limit
highlight ColorColumn ctermbg=magenta ctermfg=white
call matchadd('ColorColumn', '\%81v', 100)

" Highlight 160 column soft limit
highlight ColorColumn ctermbg=magenta ctermfg=white
call matchadd('ColorColumn', '\%161v', 100)

" Remap ; to :
nnoremap ; :

" DragVisual mappings
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 1

vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++
set runtimepath^=~/.vim/bundle/ag

nmap <silent> <leader>t :TestNearest<cr>
nmap <silent> <leader>T :TestFile<cr>
nmap <silent> <leader>ta :TestSuite<cr>
nmap <silent> <leader>tl :TestLast<cr>

let test#strategy = "dispatch"
"let dispatch#split_dir = "h"
let g:ack_use_dispatch = 1
let g:ack_default_options = " -s -H --nocolor --nogroup --column --ignore-dir=.git --ignore-dir=log --ignore-dir=tmp"

nmap <leader>/ :Ack<space>

" // to search for next occurance of selected text
vnoremap // y/<C-R>"<CR>

" Set ruby_default_path to keep ftplugins/ruby.vim from searching on startup (slow)
if executable('rbenv')
  let g:ruby_default_path = ["/usr/local/var/rbenv/shims/ruby"]
endif
