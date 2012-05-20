" Marc's .vimrc file

" OS X specific stuff
" set guifont=Monaco:h14
" colorscheme evening

" Copy by default to the OS X clipboard when yanking
" set clipboard=unnamed

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set backupdir=~/backups     " Don't store backups in the current directory

" set cpoptions-=B
set cpoptions=ceFs

set tags=./tags,./../tags,./../../tags,~/tags,~/dev/tags

" colorscheme borland
set background=light
syntax on

" Only do case-sensitive search if search has uppercase letter - that's smart
set ignorecase smartcase

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set makeprg=gmake

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent		" always set autoindenting on
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ttymouse=xterm  " so vim doesn't hang inside screen and tmux
set mouse=a             " enable mouse in all modes

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" shortcuts for opening .c and .h files
map gc :e %:t:r.c<CR>
map gh :e %:t:r.h<CR>

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set nohlsearch " I hate hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")

" mappings for splits from http://jmcpherson.org/windows.html:
" map <C-H> <C-W>h
" map <C-J> <C-W>j
" map <C-K> <C-W>k
" map <C-L> <C-W>l
" set wmh=0

map <C-Tab> :bnext<CR>
map <S-C-Tab> :bprevious<CR>
map ,<Left> :bprevious<CR>
map ,<Right> :bnext<CR>
" nnoremap ,,  <C-^>
nnoremap ,,  :bnext<CR>
nnoremap <SPACE> :bnext<CR>
nnoremap zl :ls!<CR>:buf /

"
" PHP stuff from http://www.schlitt.info/misc/.vimrc
"

" Set standard setting for PEAR coding standards
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Auto expand tabs to spaces
set expandtab

" Auto indent after a {
set autoindent
set smartindent

" Save some info about the session between sessions
set viminfo='50,%,n/tmp/viminfo

" Where to put swap files
"set dir='~/tmp,/var/tmp,/tmp'
set dir=/tmp

set hidden

"   Wildcard settings
"       What to ignore
set wildignore=*.o,*.so,*~,*/CVS
"       complete to longest common and list the alternatives
set wildmode=list:longest

set <M-c>=c

" Enable vimacs
" let g:VM_Enabled=1

" set wildmenu

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 
" let g:miniBufExplForceSyntaxEnable = 1
let g:Tb_cTabSwitchBufs = 1


" C formatting stuff from http://pst.corp.p4pnet.net/~pmineiro/.vimrc:
" The following sets up autoindent in the GNU coding style.
set cinoptions=(0,g0,{s,>2s,n-s,^-s,t0
set cindent

" only do that for C code
autocmd BufNewFile,BufRead *.pm,*.pl,*.pm.in,*.pl.in,*.c,*.h set formatoptions= cindent
autocmd BufNewFile,BufRead *.pm,*.pl,*.pm.in,*.pl.in,*.c,*.h set expandtab autoindent
autocmd BufEnter *.pm,*.pl,*.pm.in,*.pl.in set keywordprg=perlmegaman
autocmd BufLeave *.pm,*.pl,*.pm.in,*.pl.in set keywordprg=megaman

